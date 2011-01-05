From: Zenaan Harkness <zen@freedbms.net>
Subject: git fails on large repo clone on intermittent, or intermittently-high-latency,
 connections
Date: Thu, 6 Jan 2011 01:28:40 +1100
Message-ID: <AANLkTinkhmHpAQjraviKjqFAczThR5GtT_qdyf6Sb3nm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 05 15:29:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaUMX-0001sw-T8
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 15:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245Ab1AEO3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 09:29:12 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64408 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab1AEO3L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 09:29:11 -0500
Received: by bwz15 with SMTP id 15so15515623bwz.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 06:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=zonDD1z/kduyV17898zdrQolztVO45uaDgFO2HJmlWI=;
        b=p8ylrLNv8284tKchq5npGd6yJKAaRiiS+1+yEI3gwXHr9e0BGQlXrkeNBnwQR9VR/z
         nbqc6HeLQTtSpYgwGMDTB0YOkwG8zcKoWj3jvwPACQu8sH+mFl7FHJQdrVrTJ1MiwUnZ
         d0MWi6snNy9guqyJN2Zv6txIpKuc8etQYFYNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=C3CXofEtVLOKy/RWkQ0J/NEuDqpWdqYwLni0d+CDoEVWqBFzoJtWJ7eBxtZHRVkNG4
         wiLTvY094WxLvySSb8CdJFTkRZPs3u5ejPgTCX8qwzlfZAtNDS2R3z6H5E/AIUqL4GZW
         QTGSR/hjsDsnHvFKdcnVkCl/SpnPciQ8pzvyg=
Received: by 10.204.112.196 with SMTP id x4mr232580bkp.133.1294237750221; Wed,
 05 Jan 2011 06:29:10 -0800 (PST)
Received: by 10.204.112.210 with HTTP; Wed, 5 Jan 2011 06:28:40 -0800 (PST)
X-Google-Sender-Auth: yCd1SsLwkZTdv8FCSgK6Y4rVCXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164564>

Hi, I am trying to clone opentaps.git. The following is my third try,
and I am giving up now. As you can see I pressed <Return> every now
and then, and for the last long while, absolutely nothing downloading
- the connection has clearly died once again. My last run was
yesterday and I left it run overnight.

I cannot download (with a git clone/ initial repo), more than roughly
100MiB. I am on a satellite connection. I have also experienced this
with wireless connection about 18 months ago.

I have in the middle there (a few months ago) spent a couple months at
a friend's place, and never had the same problem - nice ADSL2+
connection, ~1.5MiB/s connections. As you can see with my satellite
(rural) and also with my older wireless (also rural) connections, I do
not get more than about 64KiB/s, but it's usually slower, and I've
always had satellite latency issues in the order of 450ms, and
sometimes the odd dropout.

As opposed to git, wget on the other hand not only retries and
continues from where it left off when it retries (HTTP protocol)
(default retry 10 times I think), but I can completely INTerrupt wget,
and start it again from an entirely different computer if I want
(using wget's --continue option), and it will (with HTTP) happily
continue right where it left off, and eventually my download
completes.

NOT so with git! :

$ git clone git://gitorious.org/opentaps/opentaps.git opentaps.git
Cloning into opentaps.git...
remote: Counting objects: 105724, done.
remote: Compressing objects: 100% (30417/30417), done.
Receiving objects:   5% (5888/105724), 10.44 MiB | 21 KiB/s
Receiving objects:   5% (5898/105724), 12.18 MiB | 51 KiB/s
Receiving objects:   5% (5920/105724), 17.47 MiB | 38 KiB/s
Receiving objects:   5% (5923/105724), 19.64 MiB | 23 KiB/s
Receiving objects:   5% (5939/105724), 30.01 MiB | 27 KiB/s
Receiving objects:   5% (6184/105724), 41.00 MiB | 47 KiB/s
Receiving objects:   7% (7818/105724), 52.77 MiB | 58 KiB/s
Receiving objects:   8% (9170/105724), 67.66 MiB | 56 KiB/s
Receiving objects:  10% (11309/105724), 70.57 MiB | 24 KiB/s
Receiving objects:  12% (13413/105724), 82.43 MiB | 29 KiB/s
Receiving objects:  12% (13495/105724), 96.81 MiB | 39 KiB/s
Receiving objects:  12% (13495/105724), 101.57 MiB | 47 KiB/s
Receiving objects:  12% (13523/105724), 142.64 MiB | 27 KiB/s
<here it died, after over an hour dead, I killed it completely>

Git cannot operate robustly with larger repos, it appears to me, on
internet connections with even slightly flaky links.

I've googled for a tar-ball of the git repo for opentaps, but found nothing.

What can I do to work around my flaky link?

How hard would it be to add a wget-like mode to git, for the initial
repo download?

TIA
Zen
