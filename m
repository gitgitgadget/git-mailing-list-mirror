Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5566DC433FE
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 15:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbhL3P4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 10:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbhL3P4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 10:56:24 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4B7C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 07:56:24 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id x15so19170177ilc.5
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 07:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=w6/sZjZsWOuEZNfafkEZ1zVda6o/khyYYhjFnOt7BDw=;
        b=Oh9UHFWls4KtiR/WkWJvZbhjomiPHn4QbvqRZS0Jo04NASjRkP864I+2ErVSwGN1mG
         rSlGowAkWMaSkunn85Ve0Jp38SiJUFsrSjjgiqG1CdcNPB6HZ0dfxqN4qcR7bTHe8hEv
         GyUTKZkvMJkxbgQvd/q2b94oYmo+Ex1PI13//DSHuGp42hIuZPFMSYsXIVfdUbsKnBv2
         PW3REeNEIqOPg96TaWH6fBZvoFeBW+blbGM9nhubXQMYrSPxIo0DEkEr00Y6qTfvGXvF
         Nw9ahZw3/T6aVi89bNzP9DxaqQSqvsTlfDthqUN0YXzk+DYQQKQDoqZdWPyBagSNkI7J
         aouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w6/sZjZsWOuEZNfafkEZ1zVda6o/khyYYhjFnOt7BDw=;
        b=4DOtzMPzejadJ9Vz9bFn+Js2PwO3eZX9huz4t+LOSsXKTZyVlvl5ESxjpXamvMhkxp
         YCQSCRT/gXR9AXFnuEo3qEm1Ki/jlaqK+opI3Esxe0VVfC9lhBxAlfIPHUHekPZh9uJd
         GF12uF4wKQ5QIxWwX3Oqm+3I/OYTkFhm86k1Is1pOsEi1MQW6xl1gccSuRH8suedCeoX
         Ufq9O+LwQKSCRD40zL4OSapm2zmBeWCjivgUp4+hoWQdGgAGSGH3UBH4xW4Hty03dh9i
         KGi6e/XiiONoTlOkF/MSWAyZW3y8m3IdzHK2ZRXWU+f37kk5geNJH/plE+SzA2BsmPFV
         adOg==
X-Gm-Message-State: AOAM530032pr5Upu06wM7JeU543fSLVbFXSt7qlQzXZAarMmrUY4GOxl
        gDRQMzWic0pMWz9PV9akHYxF1atm/n29tKXHorNNmC1pdnQ=
X-Google-Smtp-Source: ABdhPJwMNfC1A2LNFg8UKH82tJ+CyxJJyZpXkAg0Dr3dfqiMkDT3AbMp2bcr4pI8I6evktkpnjdw4Kplpmr086T15y8=
X-Received: by 2002:a05:6e02:178f:: with SMTP id y15mr14217292ilu.235.1640879782912;
 Thu, 30 Dec 2021 07:56:22 -0800 (PST)
MIME-Version: 1.0
From:   Jean-Louis FLOQUET <jese.jlf@gmail.com>
Date:   Thu, 30 Dec 2021 16:56:12 +0100
Message-ID: <CAHo1AWxzPsnLuT8JRWovtaRrGvRS8+0NyucU5K8VEnaL1xxW3Q@mail.gmail.com>
Subject: [Question] : git 2.33.1 asks every time password
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I use some scripts to do some batch operations (pull / push), using
rsa key and ssh-agent / ssh-add. I'm under Windows 10 (with all
updates).
When launching my script (see below, truncated : more than 100 repo),
I have to enter rsa passphrase (OK) then all push/pull are done
without any user interaction (no passphrase, no password, nothing)
All Git versions up to 2.33.0.2 are working fine, but since 2.33.1,
git asks every time the password.
I had to create a 'config' file within '.ssh' directory to support my
rsa key (too old format ?). Instructions according to
https://stackoverflow.com/questions/35233777/git-error-unable-to-negotiate-with-xx-xx-xxx-xxx-no-matching-host-key-type-fo
I also have seen that some people have to add 'ssh-add -K', but it
seems to be only for MacOS.
According to release notes for 2.33.1, Git Credential Manager for
Windows has been replaced by Git Credential Manager Core, but I don't
know if it is the "root" problem, and if yes, how to fix my issue.
I would greatly appreciate any help / solution. Thanks in advance.

Best Regards,
JL

===========================================================================================
transcript
user@computer MINGW64 /my_path1 (master)
$ ./pull_all.sh
Loading agent...
Adding key
Agent pid 1968
Enter passphrase for /path_to_rsa_key:
Identity added: /path_to_rsa_key (/path_to_rsa_key)
key : finish

Repository = /my_path1
git pull --quiet my_server master
Password authentication
(user@server) Password:

Repository = /my_path2
git pull --quiet my_server master
Password authentication
(user@server) Password:

Repository = /my_path3
git pull --quiet my_server master
Password authentication
(user@server) Password:

Appuyer sur touche pour continuer
user@computer MINGW64 /my_path1 (master)
===========================================================================================
rsa_key
-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED
DEK-Info: DES-EDE3-CBC,xxxxxxxxxxxxxxxx

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-----END RSA PRIVATE KEY-----
===========================================================================================
create_env.sh :
!/bin/sh

# Note: ~/.ssh/environment should not be used, as it
#       already has a different purpose in SSH.

#Create directory if not exist
mkdir -p ~/.ssh/

#Create variable
env=~/.ssh/agent.env

#Create file if not exist
touch $env

# Note: Don't bother checking SSH_AGENT_PID. It's not used
#       by SSH itself, and it might even be incorrect
#       (for example, when using agent-forwarding over SSH).

agent_is_running() {
if [ "$SSH_AUTH_SOCK" ]; then
# ssh-add returns:
#   0 = agent running, has keys
#   1 = agent running, no keys
#   2 = agent not running
ssh-add -l >/dev/null 2>&1 || [ $? -eq 1 ]
else
false
fi
}

agent_has_keys() {
ssh-add -l >/dev/null 2>&1
}

agent_load_env() {
echo "Loading agent..."
. "$env" >/dev/null
}

agent_start() {
(umask 077; ssh-agent >"$env")
. "$env" >/dev/null
}

add_key() {
echo "Adding key"
eval `ssh-agent -s`
ssh-add /path_to_rsa_key
echo "key : finish"
}

if ! agent_is_running; then
agent_load_env
fi
===========================================================================================
