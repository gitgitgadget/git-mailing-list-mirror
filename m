From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH] stash: Add stash.showFlag config variable
Date: Fri, 28 Aug 2015 10:47:42 +0900
Message-ID: <20150828014742.GA17656@sejong>
References: <1440683528-11725-1-git-send-email-namhyung@gmail.com>
 <1440688825-1303-1-git-send-email-szeder@ira.uka.de>
 <CAM9d7chUf=srU060Q4+qQ4mFBaXmRL0yQ1Ns4UeWcDj62CFoYg@mail.gmail.com>
 <CAPig+cQmTS5rRkfh1in9qR4MyP1_y9vNar7U4H3uayK6Vixa7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 04:03:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV919-0000N0-TZ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 04:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbbH1CDn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2015 22:03:43 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33744 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbbH1CDn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 22:03:43 -0400
Received: by padfo6 with SMTP id fo6so5961252pad.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 19:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0k1N/1kIWGk/3jMp+IJG1Qm/dX+OXy1CtQ9F3CSDjWg=;
        b=f7Va/BlyoB3t4Pc+LOHotLXlEZ4lpsaa208kxSZDBwYbMWXYc6Rwsq9qqXw4vklO65
         AiwJIh0qjq/swqRU4G0wrEHkLYvbsZieV9OIHVavvMRPKbMB/1vbI4gg27QOEA7eOeLv
         nBd2VzzlIpOh0XC8W58gZpfBQhD+zDO3nF3zLm1dGqmTXyXdQ5cNE5d2qiRNb6vybbhe
         i6Bv4yyH48dpr1sXbQOKpcf58Phj444dnrA5ET80A5x3GW7kNem82/9G7jfRtjOUr0G0
         ALjkuyG0rlU1G8CdeX9cWB4EIx0CWoLQFtiY1wk2BAg/GErQGXWC0267l9PC+/3bxl1B
         VV2w==
X-Received: by 10.66.233.97 with SMTP id tv1mr11157333pac.110.1440727422663;
        Thu, 27 Aug 2015 19:03:42 -0700 (PDT)
Received: from sejong ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id jt3sm3806948pbc.43.2015.08.27.19.03.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2015 19:03:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cQmTS5rRkfh1in9qR4MyP1_y9vNar7U4H3uayK6Vixa7w@mail.gmail.com>
User-Agent: Mutt/1.5.23+102 (2ca89bed6448) (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276701>

Hi,

On Thu, Aug 27, 2015 at 08:16:35PM -0400, Eric Sunshine wrote:
> On Thu, Aug 27, 2015 at 11:36 AM, Namhyung Kim <namhyung@gmail.com> w=
rote:
> > On Fri, Aug 28, 2015 at 12:20 AM, SZEDER G=C3=A1bor <szeder@ira.uka=
=2Ede> wrote:
> >>  - This hunk runs the the exact same 'git config' command twice.  =
Run it
> >>    only once, perhaps something like this:
> >>
> >>      show_flag=3D$(git config --get stash.showflag || echo --stat)
> >>
> >>    (I hope there are no obscure crazy 'echo' implemtations out the=
re
> >>    that might barf on the unknown option '--stat'...)
> >
> > What about `echo "--stat"` then?
>=20
> Adding quotes around --stat won't buy you anything since the shell
> will have removed the quotes by the time the argument is passed to
> echo, so an "obscure crazy" 'echo' will still see --stat as an option=
=2E
>=20
> POSIX states that printf should take no options, so:
>=20
>     printf --stat
>=20
> should be safe, but some implementations do process options (and will
> complain about the unknown --stat option), therefore, best would be:
>=20
>     printf '%s' --stat

That's good to know.  I'll change it that way.

Thanks for your review!
Namhyung
