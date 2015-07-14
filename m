From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: git on vagrant shared folder
Date: Tue, 14 Jul 2015 20:32:15 +0200
Message-ID: <20150714183215.GG7613@paksenarrion.iveqy.com>
References: <7C05ACF4-6536-4E60-BC92-FF7F0E266C0D@e-confirm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter =?iso-8859-1?Q?H=FCfner?= <p.huefner@e-confirm.de>
X-From: git-owner@vger.kernel.org Tue Jul 14 20:32:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF50C-0007oO-1G
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 20:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbbGNScT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 14:32:19 -0400
Received: from mail-lb0-f195.google.com ([209.85.217.195]:35201 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbbGNScT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 14:32:19 -0400
Received: by lbvb1 with SMTP id b1so785705lbv.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 11:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eCrKiSecTE/IMOpCkT0LXInlYTXWs2YfbhKaolDKpz0=;
        b=DeyhjGIBzIQUN6RU5hOhhL79rOqw+ZHjFEzlDG83sbzMISC5o1nfeSqUWvi/TLCFPG
         i8Kz9pt+WxACmiLL5BqS+hk+EDEg+CIg657yIq4rYXygWYGdZghIrXZPDqtuQU8cbpW1
         WaD8XgG/7RMMI71no/0S51TiOXf3kKlv0JUVpMwVsmCMefgA81RKjqw4V/E1wKSizfwO
         2ExrqyJwqbfXZ+104jFpAPzNjC9l0kbTvd3u3rGJZI838F+dUfq/SeelhQMh7Z2jAsgO
         Yi74Co/0MZYmaOrYnehitM4jIimzlHtyTMriVLQLW/BCpAiwgRf2CGundxf4o0iX9fUe
         xtzw==
X-Received: by 10.152.181.34 with SMTP id dt2mr38895882lac.84.1436898737287;
        Tue, 14 Jul 2015 11:32:17 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-249-17-125.bredband.comhem.se. [83.249.17.125])
        by smtp.gmail.com with ESMTPSA id a9sm455936laf.12.2015.07.14.11.32.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 11:32:16 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1ZF503-0002kz-9x; Tue, 14 Jul 2015 20:32:15 +0200
Content-Disposition: inline
In-Reply-To: <7C05ACF4-6536-4E60-BC92-FF7F0E266C0D@e-confirm.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273971>

Hi,
I don't know if this helps you, but I found two strange things with you=
r
history that I want to point out.

On Tue, Jul 14, 2015 at 05:49:43PM +0200, Peter H=C3=BCfner wrote:
> The problem:
> For development we are using virtual box controlled via vagrant with =
a shared folder on windows and mac hosts. The virtual OS ist ubuntu 14.=
04.2 LTS. In march this year we started with git in version around 2.3.=
 With cloning a repo directly in the shared folder we haven=E2=80=99t h=
ad any problems.

So you're running git on windows/os x and store the files on a shared
folder on Ubuntu? This will have some strange side effects.
Synchronization errors with the shared folder and the different file
systems used might cause a problem (or might not). This is a unusual
usecase and _very complex_ use case. I wouldn't be surprised if it
breaks (git have had several bugs on shared folders before).

My advise is to run git on the same machine as you store the git repo
on. Git should not be runned over a network (no matter if the network i=
s
local on your computer or not).


> A few weeks ago we weren=E2=80=99t able to clone and get an error: co=
uld not commit /vagrant/.git/config file. Manually we were able to chan=
ge that file and also the clone command works outside the shared folder=
=2E

Why are you trying to commit a file inside the .git dir? Files in that
dir should not be commited (and I'm pretty sure there was a patch about
this a while ago). The .git/config file for example is local to each gi=
t
repo and should not be commited.
--=20
=46redrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
