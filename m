From: Julian Brost <julian@0x4a42.net>
Subject: Re: Trust issues with hooks and config files
Date: Sun, 09 Mar 2014 18:27:04 +0100
Message-ID: <531CA468.3060604@0x4a42.net>
References: <5318ECFF.40908@0x4a42.net> <20140307210403.GA6790@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 09 18:27:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMhVL-0000SH-8a
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 18:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbaCIR1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2014 13:27:10 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:58309 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbaCIR1I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2014 13:27:08 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so2701668eek.13
        for <git@vger.kernel.org>; Sun, 09 Mar 2014 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x4a42.net; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tL4TwPCd0A+SvbIlXl/o/M8ZCbg6GFyDs0BEWr76WF4=;
        b=YrdpewRt6Q21XE8bxVFo8WnVH0CGs3KeF3HbifCQOyYHUV3SWL01Ak63k4Py4PO7DF
         tyHhBULgcyrl5Dmgd4YvYPVFtjtwsB7I7Pz0KPsw5QAmelnXFwp5s7ckdgGijlMX7dGL
         pbVtZXN71P456qhEsLMaYdmwtzBnBcK1Xdbbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=tL4TwPCd0A+SvbIlXl/o/M8ZCbg6GFyDs0BEWr76WF4=;
        b=Jy7L2gkYXo1IMYggP2IbyndUY3NdvkusojIu7tRMEONGsncjPLO5Qyik6FiFlM1GYy
         LWqHxcOHCBc/3vTpvIJ8oWZrUI2tCrGh8I1HB0eusfjwZm5pBpcpvvDcuQ8TNvDFVT/B
         cbvWTnKQ5N42StAVwJXJnkN3ubdZbtdpm87r5Bf3LIO+CkZxp8lyT//HP5LbQZO2vZmv
         O6NnRhuUKzG9monIzv+LncZ1qmudy+6VuPyqio0el7zhE9JNOud05XYvby6px5oMvVo5
         2wN1qUc9fPeRVCy3QyFB47Ib61SO+W2krAAQdnvgsY2tEiPyIzgETBgrCaPgK2D7vQj4
         LQwg==
X-Gm-Message-State: ALoCoQlEZDTpV7G7TBxw601X7Kyf52kn2tYWLjBdctzAuhh8tpCiCE60U3Qc1/LVzoufBxyMI4Aq
X-Received: by 10.14.202.136 with SMTP id d8mr30972459eeo.46.1394386027368;
        Sun, 09 Mar 2014 10:27:07 -0700 (PDT)
Received: from ?IPv6:2001:4dd0:f944:0:2677:3ff:fea3:17c4? ([2001:4dd0:f944:0:2677:3ff:fea3:17c4])
        by mx.google.com with ESMTPSA id q44sm34666599eez.1.2014.03.09.10.27.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Mar 2014 10:27:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140307210403.GA6790@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243698>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 07.03.2014 22:04, Jeff King wrote:
> Yes, this is a well-known issue. The only safe operation on a
> repository for which somebody else controls hooks and config is to
> fetch from it (upload-pack on the remote repository does not
> respect any dangerous config or hooks).

I'm a little bit surprised that you and some other people I asked see
this as such a low-priority problem as this makes social engineering
attacks on multi-user systems, like they are common at universities,
really easy (this is also how I noticed the problem).

> It has been discussed, but nobody has produced patches. I think
> that nobody is really interested in doing so because:
> 
> 1. It introduces complications into previously-working setups
> (e.g., a daemon running as "nobody" serving repos owned by a "git"
> user needs to mark "git" as trusted).
> 
> 2. In most cases, cross-server boundaries provide sufficient 
> insulation (e.g., I might not push to an evil person's repo, but
> rather to a shared repo whose hooks and config are controlled by
> root on the remote server).
> 
> If you want to work on it, I think it's an interesting area. But
> any development would need to think about the transition plan for
> existing sites that will be broken.

I can understand the problem with backward compatibility but in my
opinion the default behavior should definitely be to ignore untrusted
config files and hooks as it would otherwise only protect users that
are already aware of the issue anyways and manually enable this option.

Are there any plans for some major release in the future that would
allow introducing backward incompatible changes?

I would definitely spend some time working on a patch but so far I
have no idea of git's internals and never looked at the source before.

> At the very least, the current trust model could stand to be
> documented much better (I do not think the rule of "fetching is
> safe, everything else is not" is mentioned anywhere explicitly).

Good point but not enough in my opinion as I haven't read every git
manpage before running it for the first time.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTHKRfAAoJECLcYT6QIdBtGdkQALD24YhS2aHBzi/c6a/1+eOC
xERUshDJvU/3picpTqqwFlqHB6X53vo7uXcCmJU8oaMsGLeLrTyrX77YOzrhlkuK
kERkXGPgyoW1G4enATSURDbjW6kp7SG0lRvGTPNySqDt9FiZYTDP7CGsQRDDl8cL
al50BoNFsx9K/kiPgbDJsenDi/MAclAYlHbHJnEB6aBo06G89zwC2tECFtXewnAD
EbCKPI4tFrUZW/rWxHAEDVs+cI038nMzSNMi7I+HAMG48s+iMfFF69pkdOQjhIsc
3irisLQcKPVNRjSK/dGEKbqkAy9wziNza69tl0EgQn6ewju5NZ4xbAkWQG9LEWfZ
Ux1safkumQsAKiYfn87t5YDXZ3vDYKbChKQv/UlicobVRm0YbhitY2AQAzu+wx1V
mXmG6D91IxfR4B0+AA+3/E8huSD4JJ2laIUwIoYV+y4+ZAlxnT4cNdYiYAH4oEme
wZ9R0wsxVfUm+uFdSBqsgEpv7Bp9PRcREuVXXz0GQH0wQ8zdwOeeNvA3v6ZtodRZ
0q7WOVJpd/3j4fQoWUXFAOZxDIZVorM0dQQvbhXiwOE9UY5Gwpq22lGKHM1t+8EO
lOUCQBXjscfPgyLifdSbnaf11RGgVLERQlpz6hpEGht1J3AqF6tTZPjto+iVV97v
nObYVtMXsAtrKbka2FF+
=ps1M
-----END PGP SIGNATURE-----
