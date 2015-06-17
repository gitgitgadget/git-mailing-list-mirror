From: KK <horizn@wp.pl>
Subject: Re: slash in branch name
Date: Wed, 17 Jun 2015 20:38:57 +0100
Message-ID: <5581CCD1.4010606@wp.pl>
References: <5581C77A.3040703@wp.pl> <20150617192444.GD25304@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:39:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5JBE-0000Tn-Aj
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755697AbbFQTjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:39:20 -0400
Received: from mx3.wp.pl ([212.77.101.10]:13285 "EHLO mx3.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbbFQTjT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:39:19 -0400
Received: (wp-smtpd smtp.wp.pl 10576 invoked from network); 17 Jun 2015 21:39:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1434569956; bh=P7xQ1Z/Q49Y8zDuILwfPSSkx/wwC08T1Zu8FCQTRQt4=;
          h=From:To:CC:Subject;
          b=JpurTOg04kR8c5K2HzPA9pj68cv3IzUIIE774CecK2+6fu8FCD8U3mZ/NZs9iJ/Ay
           Tq3v1keKDZHpnpbEnSEUyc7ZA1phRXXj0erh8XjjgVD8iIIgKah7lvEK+JeNz9G9bG
           W4TO3vYv1CoVSjm71OJO17dIjkt1YCf4li+179vI=
Received: from host109-148-13-186.range109-148.btcentralplus.com (HELO [192.168.1.79]) (horizn@[109.148.13.186])
          (envelope-sender <horizn@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 17 Jun 2015 21:39:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150617192444.GD25304@peff.net>
X-WP-MailID: 349454cbb341733863dfa9f064d6c840
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000 [oYPk]                               
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271894>

On 17/06/2015 20:24, Jeff King wrote:
> On Wed, Jun 17, 2015 at 08:16:10PM +0100, KK wrote:
>
>> remote: error: invalid key: hooks.denypush.branch.versions/4.3.2
>> remote: error: invalid key: hooks.allowmerge.versions/4.3.2
>> [...]
>
> Those are syntactically bogus config keys. Keys should be of the form
>
>    section.subsection.key
>
> and only "subsection" can contain arbitrary bytes (and of course the
> value can, too). The hooks running on the server are using git's config
> system in ways that were not intended.  It should rearrange its
> organization of the data (I cannot comment much further without seeing
> the hooks themselves).
>
>> My colleague did some research about that and it seems that this commit has
>> stopped update hook working:
>>
>> commit b09c53a3e331211fc0154de8ebb271e48f8c7ee5
>> Author: Libor Pechacek <lpechacek@suse.cz>
>> Date:   Sun Jan 30 20:40:41 2011 +0100
>>
>>      Sanity-check config variable names
>> [...]
>>
>> Could you please advise how to fix/revert this?
>
> I guess we could add a "--no-really-i-am-abusing-git-config" option to
> git-config to let these pass, at least for lookups. I am not sure that
> is a good idea, though. I think your hooks are fundamentally broken for
> branches with odd characters (right now you are seeing complaints on the
> lookup side, but I suspect that you could not write a
> "hooks.denypush.branch.versions/4.3.2" entry if you wanted to, as git
> would choke on reading the config file).
>
> -Peff
>
>

hooks were downloaded from:
git://git.et.redhat.com/ovirt-server.git
