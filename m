From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 2/3] git-submodule: New subcommand 'summary' (2) - hard work
Date: Sat, 8 Mar 2008 02:23:28 +0800
Message-ID: <46dff0320803071023v48146536m9489db6c9a401824@mail.gmail.com>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
	 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
	 <d6e82710452985611fb75c9d32a1b772bf0cb529.1204306070.git.pkufranky@gmail.com>
	 <7vabli7vhr.fsf@gitster.siamese.dyndns.org>
	 <46dff0320803070850w290bfbe6hcdf74b20fcd7d8a4@mail.gmail.com>
	 <m34pbih3m9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 19:24:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXhEl-0004f8-J9
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 19:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756829AbYCGSX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 13:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755894AbYCGSX3
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 13:23:29 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:30712 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263AbYCGSX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 13:23:28 -0500
Received: by an-out-0708.google.com with SMTP id d31so146645and.103
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 10:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ru3KyTndS3vdd0GhbUT6YynCy9dBSv5O9ufQeiLnFNY=;
        b=IF9FE6TExNTGym8cTbL4fvP798BvDSvhPvAI7N/WDmZLu3gtv4ZbgP+A7ZeQ64mEHjtMQlmpuGLSyFgUKNHsAfJi3vCpjq8AwYP7jzkrmsXCSF6BCVmAi7ai/rOAH2bwnHHncXZLfA+9SPzvFpA5y5X5eUGbDhFjlLjfUn0IpL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HpV/uZrEP+yqVNvJFzi2SbpjjEd8Ceg2L2yclKdoQub/JdbpoaTzTvYQNFZGcm4JxAZmv5gYS7Io04iPbD9i4O/YEDQczUuQ7q9on0flamSu0GZPtN+PzWRUayFNcIAwssZZR9t+AFRGff2SQ5LrbgP6QU46Y8HYvnpQsKKWQJk=
Received: by 10.100.107.7 with SMTP id f7mr3921124anc.74.1204914208123;
        Fri, 07 Mar 2008 10:23:28 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Fri, 7 Mar 2008 10:23:28 -0800 (PST)
In-Reply-To: <m34pbih3m9.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76508>

On Sat, Mar 8, 2008 at 12:59 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
>  > On Sat, Mar 1, 2008 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  >> Ping Yin <pkufranky@gmail.com> writes:
>  >>
>  >>> +             test -z "$check_src" ||
>  >>> +             GIT_DIR="$name/.git" git-rev-parse --verify $sha1_src^0 >/dev/null 2>&1 ||
>  >>> +             unfound_src=t
>  >>
>  >>  You do not want to do ^0; you will not be bind a non-commit in gitlink
>  >>  entry anyway.
>  >>
>  > Actually, I need ^0. "git-rev-parse --verify sha1" will always
>  > succeed if sha1 is an valid name with lenght 40 even if the sha1
>  > doesn't belong to the repository.
>  >
>  > But what I want to verify is that the sha1 is not just valid/unique
>  > but also belongs to the submodule repository.
>
>  Don't you want "git cat-file -e <sha1>" then, unless you are checking
>  more than one sha1?
>
Hmm, yeah, the command you give has the same effect with
   "git-rev-parse --verify sha1^0"
>  --
>  Jakub Narebski
>  Poland
>  ShadeHawk on #git
>



-- 
Ping Yin
