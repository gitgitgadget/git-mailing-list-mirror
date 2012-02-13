From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [BUG] git-merge-octopus creates an empty merge commit with one
 parent
Date: Mon, 13 Feb 2012 20:20:39 +0100
Message-ID: <20120213202039.5346fa89@gmail.com>
References: <1329133736-20817-1-git-send-email-michal.kiedrowicz@gmail.com>
	<7vipjafu27.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 20:20:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx1SF-0003qc-1l
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 20:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757648Ab2BMTUq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 14:20:46 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45390 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738Ab2BMTUq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 14:20:46 -0500
Received: by eaah12 with SMTP id h12so1891130eaa.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 11:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=pXWimGjiweHrX7TvB8wsoslhNLbMaMYQDqgs+eSUHLU=;
        b=BhNEv//KeUIkaaHRXGf+mXhPafivXbJt3MJmphuuum9HqxEJh1OOwVY8hYe/CcnHoa
         uwDTQHVRYOQw62IVdltVQqYtRN+PkJyX+AVU87xbToWC6oWXUqO9c5W0seobAjaSBdUF
         YdBVwsSA8oK0fi/VH5FIDtoIiGMYh7GJfqhic=
Received: by 10.213.113.196 with SMTP id b4mr1545662ebq.0.1329160844726;
        Mon, 13 Feb 2012 11:20:44 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id a58sm64030062eeb.8.2012.02.13.11.20.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 11:20:44 -0800 (PST)
In-Reply-To: <7vipjafu27.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190653>

Junio C Hamano <gitster@pobox.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > This happens when git merge is run to merge multiple commits that a=
re
> > descendants of current HEAD (or are HEAD).
>=20
> I am reasonably sure you meant ancestors here.

I meant: ... to merge commits whose parent, grand-parent or
grand-grand-...-parent is HEAD. Commits to which HEAD may be
fast-forwarded.

>=20
> > to origin/master but accidentaly we called (while being on master):
> >
> > 	$ git merge master origin/master
>=20
> I am very tempted to throw this into "don't do it then" category.

I'm all for it. This is not a thing I would want to be doing. At
no time I would call this "a serious bug that needs fixing right
now". Except that I still think this behavior is not correct. git-merge
should not create commits that even aren't merges (they have single
parrent) and have exactly the same tree as its parent, and give it a
message "merge". Isn't this against the normal behavior of Git:
forwarding if possible and refusing to create commits that don't change
any file?
