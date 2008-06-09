From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] remote show: fix the -n option
Date: Mon, 09 Jun 2008 04:06:19 +0200
Message-ID: <484C901B.6000401@free.fr>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <alpine.DEB.1.00.0806090212270.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 04:07:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5WnC-00013o-JE
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 04:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549AbYFICGH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 22:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755535AbYFICGG
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 22:06:06 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:49430 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181AbYFICGG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 22:06:06 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 0D81212B6BB;
	Mon,  9 Jun 2008 04:06:04 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id B9A6C12B6AD;
	Mon,  9 Jun 2008 04:06:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.DEB.1.00.0806090212270.1783@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84357>

Johannes Schindelin a =E9crit :
>=20
> Would have been nice to Cc: the author of the C rewrite.

Sorry for that, will do it next time.

>>  	struct option options[] =3D {
>>  		OPT_GROUP("show specific options"),
>> -		OPT__DRY_RUN(&dry_run),
>> +		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),
>=20
> Why?

Because I think it's something different. It's more like in "route -n" =
than --dry-run
in "patch --dry-run". Don't you think ?

>> +			transport =3D transport_get(NULL, states.remote->url_nr > 0 ?
>=20
> Please rewrap.

I'm not sure what you are talking about. Should I wrap after "NULL," in=
stead of "?"?

> Maybe we need two different values of got_states; not calling ls-remo=
te=20
> and then showing things is okay, but calling ls-remote, getting an er=
ror=20
> and _then_ showing stuff is not okay, IMO.

In fact, it seems that get_ref_states() always return 0 or just die whe=
n an error
occur. And that transport_get_remote_refs() never return if something g=
oes wrong.

So, what about removing got_states and use !no_query instead ?

Olivier.
