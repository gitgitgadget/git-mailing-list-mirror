From: Gerhard Gappmeier <gerhard.gappmeier@ascolab.com>
Subject: Re: automatic submodule deinit (platform specific blacklist)
Date: Thu, 17 Apr 2014 22:11:24 +0200
Message-ID: <5350356C.3030508@ascolab.com>
References: <2348605.ZgCffZToXK@ws-gergap> <534FF724.9060707@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 22:11:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wasf0-0007V6-1r
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 22:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbaDQULq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 16:11:46 -0400
Received: from moutng.kundenserver.de ([212.227.17.24]:63607 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbaDQULo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 16:11:44 -0400
Received: from smtp.ascolab.com ([213.95.4.182])
	by mrelayeu.kundenserver.de (node=mreue105) with ESMTP (Nemesis)
	id 0MXGy5-1WP4G045Ib-00WF52; Thu, 17 Apr 2014 22:11:42 +0200
Received: from localhost (localhost [127.0.0.1])
	by smtp.ascolab.com (Postfix) with ESMTP id 97C3FE1BC9;
	Thu, 17 Apr 2014 16:11:40 -0400 (EDT)
X-Virus-Scanned: amavisd-new at ascolab.com
Received: from smtp.ascolab.com ([127.0.0.1])
	by localhost (smtp.ascolab.com [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id HP_57rta6Iui; Thu, 17 Apr 2014 16:11:24 -0400 (EDT)
Received: from [192.168.0.37] (p5080F12B.dip0.t-ipconnect.de [80.128.241.43])
	by smtp.ascolab.com (Postfix) with ESMTPSA id 45E85E1B6D;
	Thu, 17 Apr 2014 16:11:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <534FF724.9060707@web.de>
X-Provags-ID: V02:K0:iyYFE1cebQTBPCIIeXvrwKsc/byGVjg07QJ96IywAHX
 8OI0pabsN3Ce2fy4A5MIsPkp3cNrHOmAh4riZrbeZrvC/iTCr3
 ebsfqVdlHXJ7QUoZfNJwfreUgPVPk3dWuf4LrjP2nIf1B0Yd3C
 7eH3V5sZ13hvLNtBJeNBjkCuEmEutGmnvWl2lxAJay/HZ6e5k4
 0Yy7Qkr9vGiwlt4OS2FJpAc3hWJm35fKF9+2TbKdNJlx49Wf3H
 F2xd9PgrYpEDof1ZzNAhR53WApU9dAqrAgauECTEtzSsWEj6rJ
 Jezppny9CxUj37xH7DghJ+Re3EVAqOD7Z8EdM/XWugApa1cmMS
 Begt6Kx8DsJVPolIfCxU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246449>

On 04/17/14 17:45, Jens Lehmann wrote:
> Am 17.04.2014 10:02, schrieb Gerhard Gappmeier:
>> Hi all
>>
>> in our cross-platform projects we always have a certain Windows-only
>> submodule, which contains all the compatibility stuff and missing libraries for
>> Windows.
>>
>> When cloning such a repository on a Linux machine the typical procedure is:
>> git clone git@server:project.git
>> cd project
>> git submodule init
>> git submodule deinit path/to/windows-stuff
>> git submodule update
>>
>> This way you avoid wasting time and disk space to clone stuff that you don't
>> need on Linux (or on whatever non-windows machine your are actually working).
>>
>> It would be really cool to add a kind of platform specific submodule blacklist,
>> either in .gitconfig or maybe even better in .gitattributes so that we can add
>> this configuration to the repository.
>>
>> Example .gitattributes how this could look like:
>>    # common stuff
>>    *.sh eol=lf
>>    *.conf eol=lf
>>
>>    # submodule config
>>    [src/windows-compat]
>>    platforms = win32
>>
>> By default the platforms could have the value "all". But one can change it to
>> a list of platform names e.g. "platforms = linux, macosx" or "win32" like in
>> the example above.
>>
>> Such a feature would also make it possible to simply use "git clone --
>> recursive git@server:project.git" avoiding the single stops as shown above.
>>
>> What do your think? Is something like this possible?
>> Or is it even possible already somehow?
>>
>> Today I'm using a shell script to automate this steps, but this is just a
>> workaround. It would be cool if git itself could do this for us.
> What about setting "submodule.<name>.update" to "none" in the config of
> your non-Windows machines? Then they would be initialized (= the URL
> setting gets copied to .git/config) but never checked out.
great! that works.

It would be even better if we could store this config in the repository,
but this helps already a lot.

thx
