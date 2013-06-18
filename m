From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Tue, 18 Jun 2013 15:34:16 +0200
Message-ID: <vpqsj0fr19j.fsf@anie.imag.fr>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Alexander Nestorov <alexandernst@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 15:34:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uow3F-000430-4H
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 15:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316Ab3FRNeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 09:34:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46942 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932206Ab3FRNeU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 09:34:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5IDYF5X012659
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 15:34:15 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Uow37-00044k-8A; Tue, 18 Jun 2013 15:34:17 +0200
In-Reply-To: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
	(Alexander Nestorov's message of "Tue, 18 Jun 2013 15:25:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 18 Jun 2013 15:34:16 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228228>

Alexander Nestorov <alexandernst@gmail.com> writes:

> echo "test" > myfile
> chmod 777 myfile
> git add myfile && git commit -m "Test" && git push
> chmod 775 myfile
> git reset --hard origin/master

This doesn't tell what the permissions are in origin/master.

If the last line was "git reset --hard HEAD", then it wouldn't touch
myfile (it's executable in the worktree and in HEAD, so Git doesn't need
to change it). Neither the x bit, nor the ctime or mtime.

If you reset the file to a point where it was not executable, then Git
changes its executable bit, and I don't see why it would do otherwise:
Git tracks the executable bit, so when you say "reset the file to how it
was in this revision", this includes the content and executability.

Reading your message, I don't understand why you need to be able to
ignore the x bit.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
