From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Mon, 16 Feb 2015 20:50:43 +0100
Message-ID: <54E24A13.20405@web.de>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com>	<vpqtwyl90mx.fsf@anie.imag.fr> <xmqqsie565i9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Fairuzan Roslan <fairuzan.roslan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 16 20:51:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNRh4-00016h-ES
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 20:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbbBPTux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 14:50:53 -0500
Received: from mout.web.de ([212.227.15.3]:62830 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794AbbBPTux (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 14:50:53 -0500
Received: from birne-2.local ([217.211.68.12]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MBkal-1YFVbs3Frj-00AjoW; Mon, 16 Feb 2015 20:50:47
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqsie565i9.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:Cv8rxvx6NJBOQkf/UJROYzo51qSfu8IuCoMm6OEkRXB2wVWeV2J
 N7y9CcPgcvHhnkwmPp7TUr2F95SJtOxz3so/vI3ZbwFvJfN11a6z1mJxTN72Axcb0jEiHBM
 aGbaywKJe7cUa1WyDHOu/5/xS84uJID3w5nRl/H7pUMw3YBHigipiysSJKDe0W9Xx1ckniL
 YsXTJCe2g7pOxh1Z40F3Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263916>

On 16.02.15 20:06, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> The issue is that having object and pack files read-only on the
>> filesystem is a safety feature to prevent accidental modifications (even
>> though it's actually not that effective, since brute-force "sed -i" or
>> "perl -i" still accept to modify read-only files).
> 
> I did not see it as a "safety feature", and instead saw it as a
> reminder to me that I am not supposed to write into them when I
> check them with "ls -l".
> 
>> So, I'd be a bit reluctant to remove this safety feature for all users
>> if it's only for the benefit of a minority of users. Not that I think
>> the problem shouldn't be fixed, but I'd rather investigate alternate
>> solutions before using this mode = 0644.
> 
> I fully agree with you that this should not be unconditional.
> However, I am not sure if there is an effective workaround to a
> filesystem that pays attention to the mode bits of the file when
> doing an operation on the directory the file is sitting within.  It
> may be OK to introduce a new configuration variable, perhaps call it
> core.brokenFileSystemNeedsWritableFile or something, and probe and
> enable it inside init_db().
> 
> But I suspect that the single "mode = 0444" under discussion may not
> cover all places we create files, as the assumption that the we get
> a sane semantics from the filesystem permeates throughout the code.
> 
> What other glitches does AFP have?  Does it share Windows' "you
> cannot rename a file you have an open file descriptor on?"  Anything
> else?

May I ask which OS you have on the server side, and which on the client side?

I'm aware that Mac OS "speaks" AFP, but even Linux can do and there is
SW which enables AFP on  a Windows machine (all this is server side).

As a client we may have Mac OS, Linux (not sure if Windows can use APF)
What do you use ?
