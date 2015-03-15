From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: What is XDG_CONFIG_HOME for exactly?
Date: Sun, 15 Mar 2015 18:37:39 -0500
Message-ID: <CAHd499CmxwGJeW6gMARhc+cT+r3TK98m+LyyS+eCFXz8qKHrFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 00:37:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXI6Q-0003W8-P6
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 00:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbbCOXhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 19:37:41 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33214 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbbCOXhk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 19:37:40 -0400
Received: by iecvj10 with SMTP id vj10so153638588iec.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 16:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=e3BP4UMB7rlhmMslh9gt8+kbMj/8LXJiXV0pLjDxe08=;
        b=OpzRjd7CjhlD+ZIEsY/EvGllh+wUW6IixlwRk30k/VNSbtsveCTyTfPVKZhfA7/qOD
         nfH40mYwT8HgQveKBBsMwjjs/u4pvR5zcE706KRE8lgQ2VQs08iQvmhzU7SotF8KrTWz
         OyerHGA3fvc401fCbtXNifl37SK7FmQLq9wdqYLhirWvuUPxFFr+jqEhAkzAwM9H5o5Y
         Uubu3jAG6vkSHhFXDpAw5kleoKqtnaRO+MdEpfW7kU4zKBqgzfe4k0CjpJT9HZdhkFs1
         qAO93vOROHL5baRoVasMqyLju1rTHBJprsvyDrE34l8hqi+0O9A2GBPBYxzgPNmknWAu
         +38g==
X-Received: by 10.50.79.230 with SMTP id m6mr102600576igx.33.1426462659880;
 Sun, 15 Mar 2015 16:37:39 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.49.138 with HTTP; Sun, 15 Mar 2015 16:37:39 -0700 (PDT)
X-Google-Sender-Auth: 75KuEmjFBgaZnU_9BN3Z8Z_BGeI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265533>

My understanding is that git reads the priority of configuration as follows:

1. <local_repo>/.git/config
2. $HOME/.gitconfig
3. $XDG_CONFIG_HOME/git/config
4. system level git config (not sure exactly where this is; not
relevant to me on Windows)

I have a .gitconfig in Dropbox that I symlink to my home directory on
different platforms. Specifically, I share this gitconfig across
Cygwin/msys on Windows and Ubuntu.

If I can use XDG_CONFIG_HOME to leverage platform-specific settings,
I'd be able to keep platform-agnostic settings in my $HOME/.gitconfig
and put platform-specific settings in $XDG_CONFIG_HOME/git/config and
simply give XDG_CONFIG_HOME a different name on different platforms.

Is this what it was designed for? If not, what would be the best
approach for this? I was thinking of contributing a patch that would
let you specify the name of your git config in the home directory, but
I'm not sure if that is necessary. Something like this:

$HOME/$GIT_CONFIG_FILENAME, where GIT_CONFIG_FILENAME defaults to
".gitconfig" if it is not set or empty.
