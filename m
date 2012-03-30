From: Dave Zarzycki <zarzycki@apple.com>
Subject: Re: git-svn: cloning an SVN repo with sub-branches and sub-tags
Date: Fri, 30 Mar 2012 09:20:11 -0700
Message-ID: <A3CEE238-4A0F-4335-BC81-BB90885938BF@apple.com>
References: <4F7467E1.3090004@pocock.com.au>
 <92FA9CF9-7E8E-4DE6-8524-030A0AD33C9E@apple.com> <4F75A413.409@pocock.com.au>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Daniel Pocock <daniel@pocock.com.au>
X-From: git-owner@vger.kernel.org Fri Mar 30 18:40:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDesi-0002lU-Jx
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 18:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760262Ab2C3Qkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 12:40:52 -0400
Received: from crispin.apple.com ([17.151.62.50]:44805 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757167Ab2C3Qku (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 12:40:50 -0400
Received: from relay13.apple.com ([17.128.113.29])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPS id <0M1P005L0HCU0MU0@mail-out.apple.com> for git@vger.kernel.org;
 Fri, 30 Mar 2012 09:20:09 -0700 (PDT)
X-AuditID: 1180711d-b7f026d0000072e1-eb-4f75dd393e1c
Received: from koseret (koseret.apple.com [17.151.62.39])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay13.apple.com (Apple SCV relay)
 with SMTP id 89.C0.29409.93DD57F4; Fri, 30 Mar 2012 09:20:09 -0700 (PDT)
Received: from davez.apple.com (davez.apple.com [17.226.34.35])
 by koseret.apple.com
 (Oracle Communications Messaging Server 7u4-23.01(7.0.4.23.0) 64bit (built Aug
 10 2011)) with ESMTPSA id <0M1P00BV2HDK5600@koseret.apple.com> for
 git@vger.kernel.org; Fri, 30 Mar 2012 09:20:09 -0700 (PDT)
In-reply-to: <4F75A413.409@pocock.com.au>
X-Mailer: Apple Mail (2.1447)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsUiON1OXdfybqm/waMJfBZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4Mo4fmweS8FT9orjDVdZGxjXsXUxcnJICJhIfHv4nRXCFpO4cG89
	UJyLQ0igk0niw7ojjBDOSiaJ94cXMYNUMQvoSPR+/wZm8wroSRy83g/WLSzgIdH8dQ5YnE1A
	Q+LTqbtgNqeApsTSrmNgNSwCqhJTZk1hg5gjLrFu7nl2CFtb4sm7C6wQM20kVr9tAesVEqiR
	eP3iFiOILQI088/NLUxdjBxAl8pKPDhVNYFRYBaSi2YhuWgWkqkLGJlXMQoWpeYkVhoa6yUW
	FOSk6iXn525iBAVeQ6HsDsb9P/kPMQpwMCrx8CqdL/UXYk0sK67MPcQowcGsJMLbvbrEX4g3
	JbGyKrUoP76oNCe1+BCjNAeLkjhv52eglEB6YklqdmpqQWoRTJaJg1OqgdG3c4a+86MqlsOb
	rlmsWLf00Z2yIzJd4Q9bXp/0E41/4uzgwpYyo1t+0qJE0+8Zt0NvsbuUvclQ5bKdfPdwWhun
	0fk1a38xebRy6B1bPHnK4qxtyXWPNgjNiLTk11917fcLGSX7hXLCn67dWB7bxHL137Ofs95+
	PO661MTMl2UnX8lRLa39p74osRRnJBpqMRcVJwIA6FErPDgCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194379>


On Mar 30, 2012, at 5:16 AM, Daniel Pocock <daniel@pocock.com.au> wrote:

> On 29/03/2012 15:40, Dave Zarzycki wrote:
>> You can make this work, but it is very fragile, doesn't scale well, and it only works on recent versions of git. For example, from the LLVM clang project:
> 
> ...
> 
>> branches = cfe/branches/Apple/*:refs/remotes/svn/misc/Apple/*
>> branches = cfe/branches/Apple/Necropolis/*:refs/remotes/svn/misc/AppleNecropolis/*
> 
> 
> In the first line, (Apple/*), can it accidentally think that Necropolis is a branch, when it actually appears to be a directory containing branches?

Correct.

> Or does it consider all the lines in the file together?

It does not. That is why the "ignore-refs" setting is necessary. The "ignore-refs" setting tells git that "Necropolis" etc are not valid branches (because they are SVN subdirectories). The "ignore-refs" setting is useful for working around other SVN user errors too.

davez
