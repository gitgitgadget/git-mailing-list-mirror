From: Cliff Brake <cbrake@bec-systems.com>
Subject: Git server memory requirements
Date: Fri, 21 Mar 2014 13:38:01 -0400
Message-ID: <CAOd_LFwDQZGHo+gUhNKzvT2B8iavN_75KjwwC6P=W3z11d9zAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 18:38:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR3OY-0004WA-Ky
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 18:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbaCURiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 13:38:07 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44774 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbaCURiC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 13:38:02 -0400
Received: by mail-ob0-f174.google.com with SMTP id wo20so2805700obc.5
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=auBFGUri+p5Ce126sLmqNb6706BHEryoEYr2YD4C/n4=;
        b=HBEQ37FrQPa04FsN9brh72gi9tJFN63GY64KwpsILtCK8/cIYQcQRG8aTi883+Z8BY
         wpidYCA+rrG3w58scP50SChHYE06n7/d98F5fNwJb3uhoPm9LFU+5PAfimbADliI9krh
         4xNPmVCi3lWwao1mcqBujBklvfXYLpxFzQjnmi8uvE7t3TrJoeC0ZlYe74R5wbuRL2LV
         H4ftXO+8ipau2aGUBvona8sU26AAsLWmK8z6LcARK1peeZZ0mAkLSsDbyshhH8db6X/2
         ZP0JBbyjblqDnDDzyJ5vrUCuBy36FCx7t/Fc5DJs2UAxWQEVU0LlVw5Gc6pEM187oCzP
         Ip2w==
X-Received: by 10.182.151.73 with SMTP id uo9mr13443394obb.34.1395423481396;
 Fri, 21 Mar 2014 10:38:01 -0700 (PDT)
Received: by 10.182.29.137 with HTTP; Fri, 21 Mar 2014 10:38:01 -0700 (PDT)
X-Google-Sender-Auth: JYwm5npXAn_BRETlwG2j0GYPN6o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244706>

I'm trying to get an idea how much memory is required for a git server
that is hosting linux kernel repos.

What we're seeing is that git uses around 1GB of RAM on the server
when a user does a clone of the Linux kernel source over ssh.  Does
this seem about right?  Is this amount fixed, or arbitrary (trade-off
memory for speed).  It seems subsequent concurrent clones use less
memory.

Is there any practical way to reduce the memory usage?  We're running
into occasional issues if there are multiple clones at once.

Is setting gc.auto=0 a good idea for large kernel repos?  The idea is
we can repack manually or in a cron on weekends rather than during
user operations.  However, manually running a git gc seems to use
about as much memory as a user clone.

It may be that our EC2 small instance (2.5GB) is not up to the task,
but would like to understand options (we can easily trade off some
speed for less memory if we can) before upgrading.

Thanks,
Cliff
