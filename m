From: Mick Ken <micks80@gmail.com>
Subject: Git issue with connection keep-alive
Date: Fri, 18 Mar 2011 10:59:16 -0400
Message-ID: <AANLkTik==xnTxhOY-CoE5_oNkE-gdfSDBzBOgOgJGTbt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 15:59:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0b98-0003gO-H6
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 15:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756257Ab1CRO7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 10:59:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49469 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab1CRO7R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 10:59:17 -0400
Received: by iwn34 with SMTP id 34so4061195iwn.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=2WPJFcw535+sZg9b707u+JRaxiwkGZea7QPOLoN5Mug=;
        b=t99aqVsQBl+QqVquln9JvOwWtMIwC5KBqCzmCscDcBGhNCEq7haaZxlGMlPX1ca1Hw
         yDYOxRIPNb1i3Z/fTXQwhLOdcuu7lAbr3ro0kmz/WkPHm8kG+nfpkZB2nFMb3GLBqCqo
         xrc/McoYapu6ptW8srP97ITrDqh4dkmYZKacE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=FwaQVkN34dQDJeEt9sWM5Y/WPEqllYfX9ykwe4Y7MWTSmBgo0vlZ9O7joLgKb4g0Dv
         TGcNFoxwmUYwNj2nuzD3MUanWzmWubpUoKVTT/OSi0mXQJRFuQalxGgaLBsXMNamvfUs
         jnYEcgLg4JewUxY/U8E205eP5SpdoKaCwu+AE=
Received: by 10.42.131.10 with SMTP id x10mr1647578ics.206.1300460356886; Fri,
 18 Mar 2011 07:59:16 -0700 (PDT)
Received: by 10.42.178.67 with HTTP; Fri, 18 Mar 2011 07:59:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169329>

Hi,
I am experiencing an issue with Git plugin in Jenkins. I have already
posted the issue at the Jenkins mailing list but did not heard much in
the last couple of days, so I thought of posting it here incase
someone can help:

Jenkins mailing list thread -
http://groups.google.com/group/jenkinsci-users/browse_thread/thread/6f9d685d6aef4c49?hl=en

In short, the issue is that when the Git plugin is trying to clone a
repo it's failing but "Tortoise Git" on the same server is able to
successfully able to clone the repo. After some debugging it looks
like the Git calls are different, here's the internal Git call from
Jenkins that's failing:

C:\workspace>git clone http://<server_url>/project.git C:\Projects\
trace: built-in: git 'clone' 'http://<server_url>/project.git' 'C:
\Projects\'
trace: run_command: 'git-remote-http' 'origin' 'http://<server_url>/
project.git'
Cloning into C:\Projects\...
trace: run_command: 'fetch-pack' '--stateless-rpc' '--lock-pack' '--
thin' '--no-progress' 'http://<server_url>/project.git' 'refs/heads/
master' 'refs/heads/m3/master'

Whereas, the tortoise git is just passing the "--progress -v"
parameters and it's successful.

Any ideas why the Git call from Jenkins is dropping the connection?

Thanks
