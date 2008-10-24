From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 14:15:26 +0200
Message-ID: <cb7bb73a0810240515x4d57ea03w1b245f83d740ddfd@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <m38wsei8ne.fsf@localhost.localdomain>
	 <cb7bb73a0810240352u28bab2b5p907065680985270a@mail.gmail.com>
	 <200810241332.32487.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jean-Luc Herren" <jlh@gmx.ch>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 14:16:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtLar-0008Ta-TN
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 14:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbYJXMP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 08:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbYJXMP3
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 08:15:29 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:60949 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbYJXMP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 08:15:28 -0400
Received: by yw-out-2324.google.com with SMTP id 9so276136ywe.1
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 05:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0y5KlaaSNiQDtlSkjNn4oAuLZvuZK79NwYpXP6Q4VbI=;
        b=xhsnmKC0hndl4cnqO3A7y3iUZcmwhbEVEVEoQ8upj0QowUicF1AoojAbpli1TAdEoM
         M/W9t6jptwtgj45ZMHPI+Kfn4rY/8FLCyhh2Bfu7nGpQeIBZehXP6Dims2UmbonU9waC
         Vf1KFo5bsHH/AP1fEQauGr8E8oB/ZmheLQQP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Lz74MQpZ1/rlustVI+cxMpN5LjB8FPSatGRFjqsSb9ih9YJNR2xiYVJ+kAY0luSoBw
         5mDoD3Wde2psBFVGY/DDb0ffU9oG8Rqc8Q75uYnZWoaSAD+t7FgxMgPjO4gkZ6dRiYEH
         3C8K2va9FhZGAcE+oyZ8HPwt9xI17Ew/2hm3Q=
Received: by 10.151.39.2 with SMTP id r2mr5776052ybj.108.1224850526777;
        Fri, 24 Oct 2008 05:15:26 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Fri, 24 Oct 2008 05:15:26 -0700 (PDT)
In-Reply-To: <200810241332.32487.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99029>

On Fri, Oct 24, 2008 at 1:32 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Fri, 24 Oct 2008, Giuseppe Bilotta wrote:
>> On Fri, Oct 24, 2008 at 12:31 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> By the way RCS which I use for version control of single files use
>>> both approaches: it can store 'file,v' alongside 'file' (just like
>>> your '.zit.file/' or '.file.git/'), but it can also store files on
>>> per-directory basis in 'RCS/' subdirectory (proposed '.zit/file/' or
>>> '.zit/file.git/' solution)
>>
>> Indeed, there's not particular reason why both solutions shouldn't be
>> available. [...]
>
>> The only problem then is priority. When looking for a file's repo, do
>> we look at .file.git first, or .zit/file.git? How does RCS behave in
>> this case?
>
> rcsintro(1) states:
>
>  If you don't want to clutter your working directory with RCS files, create
>  a  subdirectory called RCS in your working directory, and move all your RCS
>  files there.  RCS commands will look *first* into that directory to find
>  needed files.

Cool. I pushed changes to this end to git.oblomov.eu/zit --now zit
will look for .zit/file.git first, then for .file.git; if neither is
found, and .zit/ exists, the repo is set to .zit/file.git, otherwise
it's set to .file.git

You can either manually mkdir .zit, or use zit init that does exactly
the same thing.

>>> By the way, it would be nice to have VC interface for Emacs for Zit...
>>
>> I'm afraid someone else will have to take care of that, since Emacs is
>> not really something I use.
>
> I'll try to hack it using contrib/emacs/vc-git.el as a base...

Cool, thanks.

-- 
Giuseppe "Oblomov" Bilotta
