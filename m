From: "R. Diez" <rdiezmail-temp2@yahoo.de>
Subject: How to check out the repository at a particular point in time
Date: Mon, 22 Aug 2011 13:25:02 +0100 (BST)
Message-ID: <1314015902.48377.YahooMailClassic@web25403.mail.ukl.yahoo.com>
Reply-To: rdiezmail-temp2@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 14:25:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvTZE-0007Cj-8K
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 14:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919Ab1HVMZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 08:25:06 -0400
Received: from nm7-vm1.bullet.mail.ukl.yahoo.com ([217.146.183.237]:45079 "HELO
	nm7-vm1.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751818Ab1HVMZE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 08:25:04 -0400
Received: from [217.146.183.211] by nm7.bullet.mail.ukl.yahoo.com with NNFMP; 22 Aug 2011 12:25:02 -0000
Received: from [217.146.183.61] by tm4.bullet.mail.ukl.yahoo.com with NNFMP; 22 Aug 2011 12:25:02 -0000
Received: from [127.0.0.1] by omp1030.mail.ukl.yahoo.com with NNFMP; 22 Aug 2011 12:25:02 -0000
X-Yahoo-Newman-Property: ymail-5
X-Yahoo-Newman-Id: 565435.62898.bm@omp1030.mail.ukl.yahoo.com
Received: (qmail 64113 invoked by uid 60001); 22 Aug 2011 12:25:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1314015902; bh=daSANH+kBOdil6fEn/E4Nbvpi+LZ6cFSMRWt+NdSIDM=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=0lv26AI3Vr84SWJ7mN6vkVlV6G/EZX9LjwUvd6jTvTHW2si8DsIoDRk8VkM35+pN5nP59gvuqRvV8VuqaK5rujDmVEGYL5d/4yNABkvxXupeulKgBocbkMlH5zd/3LuFF6xp74xTMi6MNnH6nYlfVfidzGl+chTQtrGGMsg1PCY=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=EdlMhtfrs3TqqohRldkQAHvc1VnC+GCKFF++oxbEdhvvJxiuLzAPgYL0PS+hctz+6eAjO4TmqUwuA0fQQwcw+/q1krigBaFgJLNZu8vkJ8BmYBPVJRIHfwK0WbTdCcJM4QatP1GYd1/++NYx/dp4EZDeC74GOl94BC4kp6neMJI=;
X-YMail-OSG: Uco_N9sVM1mzaKcDdc4B833.DmzeFg7fW2EPJ.a8NgwH129
 MUkgEzh3j92zeGRukUv5tjyiUPWyY30cX7cV1UgXp6WCTTwRuR_Tyoaopdiv
 6LQXAth8EIqpnobrpMF_47G2HOeKWQ17JoSgW_y2cJwOAVihFJjPNNPO99P1
 TjipKaEZNAHMG5RCPvH0hZgHPKoKtlB0AXqJhTXGcZ6WHAfVoMbsMbHCek.o
 Prq8a7NLZ2gB4d2sAvZvQ917n3qGWaXq4Y9fKVpufw1OCP8tFMfQeddmCmdm
 GY5I.t_L6BJnUt9cI69Na.gxNqQDWUgF6sFuizATk.VI2H5PuUX60tJXui5Q
 PS6qMXozBSh8TavwjXnEjBoBJRK2gpxUtArgor3pgP4_ARbj9tGvVVR1WA6W
 BJXvZdhylMfDjA3rInA--
Received: from [188.72.244.61] by web25403.mail.ukl.yahoo.com via HTTP; Mon, 22 Aug 2011 13:25:02 BST
X-Mailer: YahooMailClassic/14.0.4 YahooMailWebService/0.8.113.313619
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179860>

Hi all:

I'm writing a daily build script for all the OpenRISC components, so every day I need to check out several git repositories with the source code of many tools that depend on each other.

The hole process takes hours. In order to minimize the risk of repository skew, I thought I could just take the current date and time, clone all repositories to my local PC and check them all out at that particular timestamp.

I figured out that something like git "checkout HEAD@{2011-08-21 10:00:00}" does not really cut it. I'm getting this warning:

  warning: Log for 'HEAD' only goes back to Sun, 21 Aug 2011 10:00:02 +0200.

The reason is, the timestamp was taken at 10:00, and the repository was cloned 2 seconds later, which means that 10:00 is earlier than the repository. That was totally unexpected, but then I found this in the documentation for "gitrevisions":

  Note that this looks up the state of your local ref at
  a given time; e.g., what was in your local master branch last week.
  If you want to look at commits made during certain times,
  see --since and --until. 

I guess that means the HEAD@{date} syntax does not do what I expected. But hey, it's not the first time I find the git docs hard to follow... }8-)

By the way, it would be nice if the gitrevisions documentation could be improved, as I still don't understand what that really means. Say, for example, an hour ago I had temporarily checked out last year's versions, but half an hour ago I went back to this year's versions. If I check out at HEAD@{1 hour ago}, will I get then last year's version, or this year's?

Anyway, my real problem is with the mentioned --until option. "git checkout" does not understand that option, so I guess I need to feed the date to some other git command in order to get the commit ID for "git checkout", right? Can someone help me here?

Or even better, can someone add this kind of explanation to the "git checkout" documentation? If you are used to other version control systems, and wish to checkout the versions at a particular date, that's the documentation page you first look at.

For extra karma points, git checkout could understand the --until option itself.

Many thanks in advance,
  R. Diez
