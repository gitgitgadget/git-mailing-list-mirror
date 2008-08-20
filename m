From: "Boaz Stuller" <boazstuller@gmail.com>
Subject: Re: Problem with git-svn
Date: Wed, 20 Aug 2008 13:45:37 -0400
Message-ID: <5979e28c0808201045i2c525d7dx7fc8d70a67e9c9ef@mail.gmail.com>
References: <5979e28c0808190641l343ed48fi75c55f9f0cdb1bcf@mail.gmail.com>
	 <20080820080528.GA16665@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 19:46:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVrlb-0007l1-PK
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 19:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbYHTRpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 13:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbYHTRpi
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 13:45:38 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:30333 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbYHTRpi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 13:45:38 -0400
Received: by wf-out-1314.google.com with SMTP id 27so676906wfd.4
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zhul/kR2PAxvsMc5uW1Db/3ilfvr6dMLfI+zrMrdJWE=;
        b=VicAOBN4N0A7hMA3XZMxd9D2Hh4+fRxvhstXffuxWZKTBa75nV9LwpdA4VDJFs5XC2
         pZPfoVwid777yRhf/U+PqyCOscrQ5D5shtpBCUYiP6UYOy45CRXJdIUo82NvPgaaW1G9
         +FQNnw6Ia9s02elXxD45TV9CkeHHd8ZcCplpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YUS4jl68KC53LHBDHK9cU9723SuP03a4wZHi2PhUivepDrt9wd1Wme6sgu0RJK/6Xr
         4a0t04nsu0ITV3dObYqA7pvGKlACDYevWTmfPOCzRjDHKb4cnFdf0C/KWKm4UU0ZO6FX
         lrHVRED24ggV9nMVoSmL1h03jmohuSvtQrQnE=
Received: by 10.142.234.16 with SMTP id g16mr116054wfh.274.1219254337422;
        Wed, 20 Aug 2008 10:45:37 -0700 (PDT)
Received: by 10.143.165.3 with HTTP; Wed, 20 Aug 2008 10:45:37 -0700 (PDT)
In-Reply-To: <20080820080528.GA16665@untitled>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93000>

On Wed, Aug 20, 2008 at 4:11 AM, Eric Wong <normalperson@yhbt.net> wrote:
> Boaz Stuller <boazstuller@gmail.com> wrote:
>> I'm having a problem with git-svn.  I was connecting to a remote svn
>> repository via the svn+ssh:// protocol using an embedded username in
>> the url, i.e svn+ssh://boazstuller@svn.example.com/some/complicated/path.
>>  When I upgraded to 1.6.0, 'git svn dcommit' stopped working and
>> instead kept asking me for a password.   I tracked the problem down to
>> the following commit:
>>
>> commit ba24e7457aa1f958370bbb67dfb97e3ec806fd4a
>> Author: Eric Wong <normalperson@yhbt.net>
>> Date:   Thu Aug 7 02:06:16 2008 -0700
>>     git-svn: add ability to specify --commit-url for dcommit
>>
>> I don't know perl, but the problem seems to be where around line 446,
>> '$gs->full_url' gets changed to  '$url'.  Apparently, $gs->full_url
>> contained the embedded username but $url has it stripped out, i.e
>> svn+ssh://svn.example.com/some/complicated/path , so ssh can't tell
>> what username I'm trying to log in as.
>
> Hi Boaz, thanks for tracking this down.  The following patch should
> fix your issue (and another potential one I noticed).
>
> I've lightly tested it and it appears to work for me.
>

I only tested with a couple commits too, but your patch works
perfectly for me.

Thanks,
Bo
