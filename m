From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [BUG?] applypatch-msg hook no-longer thinks stdin is a tty
Date: Sat, 3 Oct 2015 11:08:52 +0200
Message-ID: <560F9B24.6030605@kdbg.org>
References: <CAFOYHZArBv=2E_YonCqOSC4mWk9=xkbG9FyB+zNFFAqmUBUKHA@mail.gmail.com>
 <xmqqvbap5kbr.fsf@gitster.mtv.corp.google.com>
 <xmqqr3ld5fok.fsf@gitster.mtv.corp.google.com>
 <CAFOYHZC9ju5Yg9LkYwiwXC+D0QZGs1isetYd-XvyhwhcZuJK+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>
To: Chris Packham <judge.packham@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 11:18:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiIxe-0005I1-QB
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 11:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbbJCJSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 05:18:10 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:18391 "EHLO bsmtp5.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbbJCJSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 05:18:09 -0400
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Oct 2015 05:18:09 EDT
Received: from bsmtp4.bon.at (unknown [192.168.181.106])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 3nSj6c40Bfz5tn5
	for <git@vger.kernel.org>; Sat,  3 Oct 2015 11:08:56 +0200 (CEST)
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nSj6Y3mZCz5tlG;
	Sat,  3 Oct 2015 11:08:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id E753852CE;
	Sat,  3 Oct 2015 11:08:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <CAFOYHZC9ju5Yg9LkYwiwXC+D0QZGs1isetYd-XvyhwhcZuJK+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278964>

Am 03.10.2015 um 09:37 schrieb Chris Packham:
> On Sat, Oct 3, 2015 at 6:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> If you want to go interactive from the hook, you'd have to open and
>> interact with /dev/tty yourself in your hook anyway.
>
> That may be what I have to do, although I have absolutely no idea how.

Something like this:

exec <>/dev/tty 1>&0 2>&0
printf "what now: "
read answer
echo the answer was: "$answer"

-- Hannes
