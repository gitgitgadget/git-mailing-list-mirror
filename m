From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 16:09:18 +0700
Message-ID: <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com>
 <5296F343.6050506@gmail.com> <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
 <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
 <5297004F.4090003@gmail.com> <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
 <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: zhifeng hu <zf@ancientrocklab.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 10:10:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlxbk-0002q8-1p
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 10:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab3K1JJy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 04:09:54 -0500
Received: from mail-qe0-f41.google.com ([209.85.128.41]:54786 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab3K1JJt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 04:09:49 -0500
Received: by mail-qe0-f41.google.com with SMTP id gh4so6283533qeb.0
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 01:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=96y+o3UXf2VcPMZJ934QIWysnvK/HUMURX/hoFFdIpQ=;
        b=tE7cICY4c5HYp3gnh3nQQwlt2BZ4lwb+Nwq/t8ZdYDOhixtCdljzpOKv+kephDN8CG
         GSEHsxowY+fIvM7EX+QeNZKqM/rrGonZVgoqg6CagUkmz16QiEEdNU5/PhNX9jkxZ5HB
         f5mise2nHHBY2Zmnovgq0Y/X5gmoENgfGuP0CpH14ruXTOP8J8CCzSrPAqfNMtPdvhFr
         itJAE32ISAqCqDbgyAbedW2PFAlBO9xios4hAIi5lPROPRFfXwKCxVKRuk4R+tgSngfx
         hKR3qPKop5yV0KMjyTsAVKCVNSMwERMpD6gPhJm6qMMf1IhHmnDUUXNY7RZ9QIeyJmwR
         Hcnw==
X-Received: by 10.224.51.7 with SMTP id b7mr74986979qag.74.1385629788952; Thu,
 28 Nov 2013 01:09:48 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Thu, 28 Nov 2013 01:09:18 -0800 (PST)
In-Reply-To: <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238483>

On Thu, Nov 28, 2013 at 3:55 PM, zhifeng hu <zf@ancientrocklab.com> wro=
te:
> The repository growing fast, things get harder . Now the size reach s=
everal GB, it may possible be TB, YB.
> When then, How do we handle this?
> If the transfer broken, and it can not be resume transfer, waste time=
 and waste bandwidth.
>
> Git should be better support resume transfer.
> It now seems not doing better it=E2=80=99s job.
> Share code, manage code, transfer code, what would it be a VCS we ima=
gine it ?

You're welcome to step up and do it. On top of my head  there are a few=
 options:

 - better integration with git bundles, provide a way to seamlessly
create/fetch/resume the bundles with "git clone" and "git fetch"
 - shallow/narrow clone. the idea is get a small part of the repo, one
depth, a few paths, then get more and more over many iterations so if
we fail one iteration we don't lose everything
 - stablize pack order so we can resume downloading a pack
 - remote alternates, the repo will ask for more and more objects as
you need them (so goodbye to distributed model)
--=20
Duy
