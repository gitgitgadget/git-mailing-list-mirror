From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC] URL rewrite in .gitmodules
Date: Sun, 15 Nov 2015 14:16:13 +0100
Message-ID: <289C8789-5102-4721-994E-E0B39FD1BFD0@gmail.com>
References: <DCA9FD0F-252B-4CD7-9137-395771CBC62E@gmail.com> <xmqqio618mxc.fsf@gitster.mtv.corp.google.com> <F01EF930-9787-44DD-A2E5-F5FBA029D3E7@gmail.com> <CAGZ79kbFDB55mKnw-ONPGBmHfeXZDBKOb=HrjjepiBh3kgcO1g@mail.gmail.com> <562E5A31.7050903@web.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 15 14:16:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxxAm-0006gU-Eb
	for gcvg-git-2@plane.gmane.org; Sun, 15 Nov 2015 14:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbbKONQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2015 08:16:17 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34717 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbbKONQQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2015 08:16:16 -0500
Received: by wmvv187 with SMTP id v187so140369211wmv.1
        for <git@vger.kernel.org>; Sun, 15 Nov 2015 05:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CINOmaiqVmKh9TKSTOgGMu4hK/6VIoaKgxOD8FlxijY=;
        b=yij01qWh6HcTiFuXp+yQcMm+s8ozEY12tMX66359nnAlROokJPI189/AKQthwY3PYK
         Z5zUY1AofqINrPd3tDlF7jZDWGnPv2Z5JaJsZeTlnpvdqQFtFPlv0Y3ulmaGic5a5EPf
         D+ZfirPV3F2bfXD9LoLiZM3yPzqLQTS4UYs8oEU49QhzOLF2Yx4x7q5d1Sn1qjh2UPoz
         VUNGxz0VWChH4o6O0xMgwQcoeJq/zI21VT0PqChtryrY+IPo+TXL4FCk0E9/2c5TjvAW
         jhe6/jBjNVWbfc1ORn+VM3s8YeOqlPpx9kraBqy7sVN11ScDBiqL845maVQxLTVVdfzm
         wetA==
X-Received: by 10.28.126.215 with SMTP id z206mr14051593wmc.71.1447593375131;
        Sun, 15 Nov 2015 05:16:15 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB712F.dip0.t-ipconnect.de. [93.219.113.47])
        by smtp.gmail.com with ESMTPSA id t126sm13445584wmd.23.2015.11.15.05.16.14
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 15 Nov 2015 05:16:14 -0800 (PST)
In-Reply-To: <562E5A31.7050903@web.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281320>


On 26 Oct 2015, at 17:52, Jens Lehmann <Jens.Lehmann@web.de> wrote:

> Am 26.10.2015 um 17:34 schrieb Stefan Beller:
>> On Sun, Oct 25, 2015 at 8:12 AM, Lars Schneider <larsxschneider@gmail.com> wrote:
>>> On 20 Oct 2015, at 19:33, Junio C Hamano <gitster@pobox.com> wrote:
>>>> I do not think this topic is specific to use of submodules.  If you
>>>> want to encourage your engineers to fetch from nearby mirrors you
>>>> maintain, you would want a forest of url.mine.insteadof=theirs for
>>>> the external repositories that matter to you specified by
>>>> everybody's $HOME/.gitconfig, and one way to do so would be to have
>>>> them use the configuration inclusion.  An item in your engineer
>>>> orientation material could tell them to add
>>>> 
>>>>       [include]
>>>>               path = /usr/local/etc/git/mycompany.urlrewrite
>>>> 
>>>> when they set up their "[user] name/email" in there.
>>>> 
>>>> And you can update /usr/local/etc/git/mycompany.urlrewrite as
>>>> needed.
>>> Oh nice, I didn't know about "include". However, as mentioned to Stefan in this thread, I fear that our engineers will miss that. I would prefer a solution that does not need any additional setup. Therefore the suggestion to add rewrites in the .gitmodules file.
>> 
>> How do you distribute new copies of Git to your engineers?
>> Maybe you could ship them a version which has the "include" line
>> already builtin as default? So your distributed copy of Git
>> would not just check the default places for configs, but also
>> some complied in /net/share/mycompany.gitconfig
> 
> Which is just what we do at $DAYJOB, that way you can easily
> distribute all kinds of settings, customizations and hooks
> company-wide.

That's a very good idea. I will try to establish this practice, too.

Thanks,
Lars