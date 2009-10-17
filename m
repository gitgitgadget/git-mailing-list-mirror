From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] Add proof-of-concept %[w(width,in1,in2)<<any-string>>%] implementation
Date: Sat, 17 Oct 2009 02:00:02 +0200
Message-ID: <200910170200.03681.jnareb@gmail.com>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com> <200910170020.01756.jnareb@gmail.com> <7v7huurkif.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 01:59:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MywhT-0001qd-Sh
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 01:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbZJPX6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 19:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbZJPX6r
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 19:58:47 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:42773 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbZJPX6q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 19:58:46 -0400
Received: by fxm18 with SMTP id 18so3040294fxm.37
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 16:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/VzZPlVDcTQ3Lwyi/dP54vNcoUKxn7HS7bjP4UvsdYw=;
        b=d11nUDDLi8C8ea4bjtM+U+nHQ6DVfc65nir9xG83ekBZrf+MunoNd0H1zx+YEcSzWN
         as06E94ce0ad3Y1UKQlEOzegSN31WFB6OTBE5R8acyB4DAjlH/tkg6YKuhbkscQq8x/O
         ItwGYRXKTrY7Lbb5u0dA+mY7CHS5mzDlWJW6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gWO5Y5uY4jt6sn7lYzb3BLUUFKJeSMo5FBW6gyq1i4c/Px7/LTMgDyrASgdKHcoge4
         5+7UzFmUqZvYhpL1Uo8cGoWT0Zs1DFHFYNS+eCTdEB7ChC5prP5y9mFLjfDDd1bmkZVj
         LsDVGeMq4r7pccfkqm2GdbJU5A7iphGLtxKkI=
Received: by 10.204.160.143 with SMTP id n15mr1905888bkx.183.1255737530419;
        Fri, 16 Oct 2009 16:58:50 -0700 (PDT)
Received: from ?192.168.1.13? (absh57.neoplus.adsl.tpnet.pl [83.8.127.57])
        by mx.google.com with ESMTPS id 15sm298131bwz.0.2009.10.16.16.58.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Oct 2009 16:58:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v7huurkif.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130538>

On Sat, 17 Oct 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > But even with original w(<width>,<indent1>,<indent2>) we can get output
> > of bare "git log" using pretty format... well, almost; it would be the
> > same if there was ability to put infinite width, and there doesn't seem
> > to be specifier for the whole, unchanged commit message (subject,
> > unwrapped + separating lines + body).
> 
> I think I already discussed this when I sent out %s%+b patch.  You would
> need to adjust and apply both series, but essentially it would become
> something like:
> 
>     %s%+[w(-1,4,4)%b]
> 
> I.e. a single subject line, potentially followed by a LF and body indented
> by 4-place, but the LF will be there only when the body is not empty.

Why not

    %[w(-1,4,4)%s%+b]

Or is it

    %[w(-1,4,4)%s%+%b]

(i.e. %+ is this empty line between subject and body, if it exists).

The %+x seems a bit strange... but I guess implementing conditional
expansion a la shell or rpn spec/queryformat would be out of question
(i.e. %?s:+ )...
-- 
Jakub Narebski
Poland
