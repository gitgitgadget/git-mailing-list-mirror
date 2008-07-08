From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Tue, 8 Jul 2008 19:31:31 +0200
Message-ID: <200807081931.31764.jnareb@gmail.com>
References: <200807080227.43515.jnareb@gmail.com> <200807081812.15651.jnareb@gmail.com> <20080708163430.GK6726@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jul 08 19:33:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGH3X-0000fJ-N4
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 19:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbYGHRbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 13:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753753AbYGHRbs
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 13:31:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:11358 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbYGHRbr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 13:31:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1206284ywe.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 10:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ekVgUrPVnfe2JnQg156OOFUaYETwHMVxh3pAxqdpiBk=;
        b=x3LZK6goqDlhxwGlkw7TFX7Xw7kvWqsEIvFPdLEUo/oITpTgcnHEmX1xcX392aXD2a
         OptPupMA8lp0yd3Rr5plErNuXisPJaeaej8VKkUgt4r14luHE/gOG0uNilDUssymQsRl
         wuvfC6/oLwBh5Rj6q2uaDeMtuM+Sv4GpPghLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=n2YSy4d6rrHdGx7TU2WljXTCgIFAqumuhRa2x2SQxAU4PnvyL8/CTIOg5a0/ZfkhfL
         3DrmxrRrZObL2yMt87ezjJl8w6GwxPtMRGHgzB/V/b+AsJeQ1UP5oH/WUuAPiTZK4nww
         03CQTEl6aNvxChTWDhnbJrz9jyZ0b00GRsHjY=
Received: by 10.125.114.19 with SMTP id r19mr1464591mkm.46.1215538296925;
        Tue, 08 Jul 2008 10:31:36 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.205.145])
        by mx.google.com with ESMTPS id p25sm2171428hub.32.2008.07.08.10.31.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jul 2008 10:31:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080708163430.GK6726@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87776>

Hi!

On Wed, 8 July 2008, Stephan Beyer wrote:
> Jakub Narebski wrote:
>> Stephan Beyer wrote:
>>>
>>> It is taking the commit message from the commit in the "From <commit> .*"
>>> line, does *not* change it in any way and then applies the changes using
>>> threeway merge.
>> 
>> Not exactly.  "git am --rebasing" still tries to first just *apply*
>> the patch, then (I think) it falls back on blob-id based 3way merge.
> 
> That's of course totaly right and what I've meant, but unfortunately not
> what I've written ;-)
> 
>>> Keeping that in mind what about dealing with --rebasing like that:
>>> if --rebasing is given, git am simply generates
>>> 	pick <commit>
>>> lines, instead of
>>> 	patch -3 -k <msg>
>>> as it is now (and this is not enough, as it seems).
>> 
>> It is not.
>> 
>> Nevertheless it would be I think better for ordinary patch based rebase
>> to fall back not on git-am 3way merge, but on cherry-pick based merge
>> (i.e. on pick).
> 
> Hmm, if I get you right you _partly_ agree with me in choosing "pick" for
> am --rebasing... But cherry-pick should only be chosen if a simple git-apply
> failed first. Right?

Right.

> I just got another idea which could easily be done and perhaps is the
> right thing :)
> Generating
> 	patch -C <commit> -3 <file>
> 
> This takes authorship and message from <commit> and does the usual
> threeway-fallback behavior.
> 
> What do you think?

Very good idea (I have proposed something similar either here on in
another thread).  It would avoid some unnecessary "marshalling" and
"unmarshalling" which is needed to transfer commit message [unchanged]
through git-format-patch -> git-am pipeline, namely putting first
paragraph into subject line, generating then parsing RFC-2822 date,
using quoted printable encoding for first paragraph / subject header
(I think).

It would be still better to fallback to _pick_, not "git am --3way",
as the latter IIRC use _shortened_ _blob_ identifiers for pre- and
post-image to find common ancestor (merge base) for 3way merge.
Which is not necessary as we can find merge base and base commits
easier.

-- 
Jakub Narebski
Poland
