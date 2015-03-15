From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: What is XDG_CONFIG_HOME for exactly?
Date: Sun, 15 Mar 2015 18:59:21 -0500
Message-ID: <CAHd499CPevdk5E-m2U5rWjiaV+zz74+Ev6hvpeLoieVPb8TFtg@mail.gmail.com>
References: <CAHd499CmxwGJeW6gMARhc+cT+r3TK98m+LyyS+eCFXz8qKHrFw@mail.gmail.com>
	<CAHd499AGHgBECH9t_EtkwLx7VCx3yVnDS27PteF3zF1xSAG8Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 00:59:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXIRL-0004P1-7U
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 00:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbbCOX7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 19:59:23 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33183 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbbCOX7W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 19:59:22 -0400
Received: by iecvj10 with SMTP id vj10so153848219iec.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 16:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=6KYGOa833Dq184DNhj3L65dYd7iw6Qh435jh31zpOIQ=;
        b=ofZBjV2t9dqWs1QtYZoKkU4MPyGDYfMf2NwtcvIbAy5G9yIoXuZu0Ht3ZM11GnEq2c
         zBgciNGU6PoWfTXzxT/xSmG70K5C3jSnZKIkSYzS2Gk6kzlzHsFFc06PdayrY0ExG4yJ
         1R2d1y2FqJoXjDLz8cSx23tttdzKOSPrZ20m7DyEv14a83Zzl/ZdW5KEeVhFnI3IRWCS
         dRvLy3WPbeZX5LTTsTuL2jX0TXBkpr+UxZJFPq9gei2ECyIssfP3XGvMEglG/l1tc7m/
         COCdeBcetKwLXVxvgbPue1Ed37x2hG579s0Reg1Dy8fMtqa2GdU2kt/Dstz6cjzviIdz
         n97Q==
X-Received: by 10.50.66.235 with SMTP id i11mr105152080igt.40.1426463961985;
 Sun, 15 Mar 2015 16:59:21 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.49.138 with HTTP; Sun, 15 Mar 2015 16:59:21 -0700 (PDT)
In-Reply-To: <CAHd499AGHgBECH9t_EtkwLx7VCx3yVnDS27PteF3zF1xSAG8Yg@mail.gmail.com>
X-Google-Sender-Auth: 4b6aZyjDMqIWvRbCuPIvGu6U9aI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265536>

Sorry for the continuous updates... it seems I spoke too soon. This
works until you CD into a repository, then none of the settings are
accessible. So yeah, basically I need to make sure I'm using this as
intended... I still don't understand the purpose of the XDG thing.

On Sun, Mar 15, 2015 at 6:50 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> As a follow-up, I tested the following in my .bashrc:
>
>
> # Utilize different GIT settings based on platform
> if [[ $OSTYPE == 'msys' || $OSTYPE == 'cygwin' ]]; then
>     echo 'Using WINDOWS specific git settings'
>     export XDG_CONFIG_HOME=.config-windows
> else
>     echo 'Using LINUX specific git settings'
>     export XDG_CONFIG_HOME=.config-linux
> fi
>
>
> This seems to work nicely!! I share my $HOME directory (located in
> dropbox) across all platforms so this helps me keep a consistent
> environment across all my machines with zero effort.
>
> On Sun, Mar 15, 2015 at 6:37 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>> My understanding is that git reads the priority of configuration as follows:
>>
>> 1. <local_repo>/.git/config
>> 2. $HOME/.gitconfig
>> 3. $XDG_CONFIG_HOME/git/config
>> 4. system level git config (not sure exactly where this is; not
>> relevant to me on Windows)
>>
>> I have a .gitconfig in Dropbox that I symlink to my home directory on
>> different platforms. Specifically, I share this gitconfig across
>> Cygwin/msys on Windows and Ubuntu.
>>
>> If I can use XDG_CONFIG_HOME to leverage platform-specific settings,
>> I'd be able to keep platform-agnostic settings in my $HOME/.gitconfig
>> and put platform-specific settings in $XDG_CONFIG_HOME/git/config and
>> simply give XDG_CONFIG_HOME a different name on different platforms.
>>
>> Is this what it was designed for? If not, what would be the best
>> approach for this? I was thinking of contributing a patch that would
>> let you specify the name of your git config in the home directory, but
>> I'm not sure if that is necessary. Something like this:
>>
>> $HOME/$GIT_CONFIG_FILENAME, where GIT_CONFIG_FILENAME defaults to
>> ".gitconfig" if it is not set or empty.
