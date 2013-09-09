From: Niels Basjes <Niels@basjes.nl>
Subject: [Proposal] Clonable scripts
Date: Mon, 9 Sep 2013 22:48:42 +0200
Message-ID: <CADoiZqpec6rPOgPLPQFFfLdE+Cc4ZKtWs0Q0VSfKGm3b1Lai2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 22:48:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ8O8-0006gI-C6
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 22:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532Ab3IIUso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 16:48:44 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:47830 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013Ab3IIUso (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 16:48:44 -0400
Received: by mail-wg0-f47.google.com with SMTP id f12so5681589wgh.26
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 13:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to:content-type;
        bh=Ypw4am92K0p/sEzZkCKNwDHtkUODPs0a8lew3JPkBxA=;
        b=XzevvHoyVbyGfJRxr4lw28ejQRoM6keBsIXCzKIroVRMmi3wBWjQYDk0xtfXjN7R5e
         8vcHkofytdsu7yfNJMFRsEsxFkkA8y4ySxmSm26vWdimQmfyCUflUsp1L0hbpKrqBHbX
         5/VTKvdjA3lVhReZr4PYgvR9ugWjov9b5n6xhEZ/WCZoQo3akAnijhFaac7wrlj0c+gp
         xU/A7t62awn7dmPIhgUFwcDYekqIVluQ67pYJwoP1/QQ5B6w8D09768XSj8kmxZY1E+R
         N9191bEzoid3hOCGYh6boMg+1863meZC7vtuDDP6cXP1CpbLDAFkVGEiUPaUDx/lrIPN
         Igsw==
X-Gm-Message-State: ALoCoQmGQZWFpwsES2nVaRWt8POb0jqiVZy1t2BXZMnDJldXxOFpS4M0G+LBK94EL4JQk0aIN5ab
X-Received: by 10.194.122.129 with SMTP id ls1mr3087632wjb.37.1378759722669;
 Mon, 09 Sep 2013 13:48:42 -0700 (PDT)
Received: by 10.194.40.71 with HTTP; Mon, 9 Sep 2013 13:48:42 -0700 (PDT)
X-Originating-IP: [2001:980:91c0:1:45cb:c539:d56c:ff5b]
X-Google-Sender-Auth: pQMfYSxuwpsetH6UpFhwIR7MiiE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234373>

Hi,

As we all know the hooks ( in .git/hooks ) are not cloned along with
the code of a project.
Now this is a correct approach for the scripts that do stuff like
emailing the people responsible for releases or submitting the commit
to a CI system.

For several other things it makes a lot of sense to give the developer
immediate feedback. Things like the format of the commit message (i.e.
it must start with an issue tracker id) or compliance with a coding
standard.

Initially I wanted to propose introducing fully clonable (pre-commit)
hook scripts.
However I can imagine that a malicious opensource coder can create a
github repo and try to hack the computer of a contributer via those
scripts. So having such scripts is a 'bad idea'.

If those scripts were how ever written in a language that is build
into the git program and the script are run in such a way that they
can only interact with the files in the local git (and _nothing_
outside of that) this would be solved.

Also have a builtin scripting language also means that this would run
on all operating systems (yes, even Windows).

So I propose the following new feature:

1) A scripting language is put inside git. Perhaps a version of python
or ruby or go or ... (no need for a 'new' language)

2) If a project contains a folder called .githooks in the root of the
code base then the rules/scripts that are present there are executed
ONLY on the system doing the actual commit. These scripts are run in
such a limited way that they can only read the files in the
repository, they cannot do any networking/write to disk/etc and they
can only do a limited set op actions against the current operation at
hand (i.e. do checks, parse messages, etc).

3) For the regular hooks this language is also support and when
located in the (not cloned!) .git/hooks directory they are just as
powerful as a normal script (i.e. can control CI, send emails, etc.).

Like I said, this is just a proposal and I would like to know what you
guys think.

-- 
Best regards / Met vriendelijke groeten,

Niels Basjes
