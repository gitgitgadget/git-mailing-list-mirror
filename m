From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: hitting home directory's parent
Date: Sat, 22 Aug 2009 23:20:39 +0700
Message-ID: <fcaeb9bf0908220920g29ec24e9v23d0504d10ca6cfb@mail.gmail.com>
References: <20090821200503.GA19660@panix.com> <fcaeb9bf0908212110o5ed1233ek11183fa37b474a06@mail.gmail.com> 
	<20090822150542.GA29507@panix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Convissor <danielc@analysisandsolutions.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 18:21:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MetL5-00043Z-Lq
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 18:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866AbZHVQU6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Aug 2009 12:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755716AbZHVQU6
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 12:20:58 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:27932 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563AbZHVQU5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Aug 2009 12:20:57 -0400
Received: by an-out-0708.google.com with SMTP id d40so1897368and.1
        for <git@vger.kernel.org>; Sat, 22 Aug 2009 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Di1FxSdZxH9hr587Gi/6mkDHR5lt+4j2ZnOtr+QjV40=;
        b=lOwCF8lomuA8zyGkJFSKJHTyaqxBlqFWQSCMUr+5SWoUm94HPk5h6W32TqmhXftg1J
         SxX7xcqLxpeF3eXnasVqbKTCa2aqrF6oQm4euTWikcPbmpCsqmxjKQyB4OJDYeAMMru8
         nKs99/6rR2qS737k8TwTuBa9fa4t2oxJg/zwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=blOCiDNuyaV9/8cF/93vfnsmbnkeKV/6vmn4Q3DMci/WQzzeU7IqKPCdp5HCVimRxP
         ACTVUsoHRPuezozRx/JaQNbNglgQixK7CH2sbGugcMbbIh/eLwjs8S73ebK0R53QvIzj
         UUanQV06vXMKxvKIL4uJsO11ikd3dffG96z8Y=
Received: by 10.101.111.14 with SMTP id o14mr2632911anm.83.1250958059160; Sat, 
	22 Aug 2009 09:20:59 -0700 (PDT)
In-Reply-To: <20090822150542.GA29507@panix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126813>

On Sat, Aug 22, 2009 at 10:05 PM, Daniel
Convissor<danielc@analysisandsolutions.com> wrote:
> Hi Duy:
>
> On Sat, Aug 22, 2009 at 11:10:18AM +0700, Nguyen Thai Ngoc Duy wrote:
>>
>> I guess it tried to find .git directory upward. I think you can set
>> GIT_CEILING_DIRECTORIES to make it stop at /home/danielc. Excerpt fr=
om
>> git.txt
>
> That didn't change the situation.

I'd suggest you to degrade Git to a version earlier than 1.6.1, when
the error was not added. :-D

But did it at least change the error message? Here is what I got when
"chmod 000 /tmp/a":

/tmp/a/b/c $ cd ../..
bash: cd: ../..: Permission denied
/tmp/a/b/c $ git --help
fatal: Cannot change to '/tmp/a/b/c/..': Permission denied
/tmp/a/b/c $ GIT_CEILING_DIRECTORIES=3D/tmp/a/b git --help
fatal: Cannot come back to cwd: Permission denied

Looks like absolute path will cause troubles anyway this case.

> I did read a bit farther in the manual and initialized a new reposito=
ry.
> Issuing "git --help" once inside that new repository works. =C2=A0Req=
uiring
> the --help command to be called from inside a repository, or even tha=
t
> it's looking for a repository at all, seems unwise. =C2=A0All it shou=
ld do is
> display the usage information and exit.

=46or simple things like --help, I agree Git should not do extra work
such as searching for Git repository, which is the cause. That was on
Jeff's plan IIRC.
--=20
Duy
