From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 3/3] gitweb: Optional grouping of projects by category
Date: Fri, 5 Dec 2008 11:45:08 +0100
Message-ID: <200812051145.09732.jnareb@gmail.com>
References: <87wsei1uvp.wl%seb@cine7.net> <200812050308.52891.jnareb@gmail.com> <87bpvr1hee.wl%seb@cine7.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: =?iso-8859-1?q?S=E9bastien_Cevey?= <seb@cine7.net>
X-From: git-owner@vger.kernel.org Fri Dec 05 11:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8YCo-0003zM-Jv
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 11:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbYLEKpT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2008 05:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbYLEKpS
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 05:45:18 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:28548 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbYLEKpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 05:45:16 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1937070eyi.37
        for <git@vger.kernel.org>; Fri, 05 Dec 2008 02:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4GQ7+rMsDfJnlS9UxHkNw7V0PwrCVHcCJLWkbRnSw7c=;
        b=jnAk0bLr4D4Ay25AMS5DSmVrkkqGsSAXEXpqmm6YfX/Nl4G2Xf2+mj1oZzv7PPMNlt
         wWdKCqlgA8SUrScEEbAlu1DXLmUAGE02cRHtUQLZ0mP4Og3lqHP7KL1HQtYbdKBeH9Ej
         OWsn9+NmtILHvDHbV5vLZ0Pk3sA+YT9daTQIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BcLqtzOeYvvUhHO3JyzP2FCftTHgsW91VP6CaJV3VLhErSn7u2I/MwTrY2A3/8wwSR
         /dji8u/fCtfaHrgsYIEkP2FNtk/uDD1bfkgDZ3QLKV5TV5hp3sN/b8/bnxp+OnEda8gg
         0puVY8r49E+7UPSOfz1cxKlrzdQg7C76TASW4=
Received: by 10.210.23.3 with SMTP id 3mr7558584ebw.124.1228473914933;
        Fri, 05 Dec 2008 02:45:14 -0800 (PST)
Received: from ?192.168.1.11? (abwe217.neoplus.adsl.tpnet.pl [83.8.228.217])
        by mx.google.com with ESMTPS id 3sm272486eyj.51.2008.12.05.02.45.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Dec 2008 02:45:13 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87bpvr1hee.wl%seb@cine7.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102397>

On Fri, 5 Dec 2008 at 03:32, S=E9bastien Cevey wrote:
> At Fri, 5 Dec 2008 03:08:52 +0100, Jakub Narebski wrote:
>=20
> > Nice... but perhaps it would be better to simply pass $from / $to t=
o
> > build_projlist_by_category function, and have in %categories only
> > projects which are shown...
>=20
> Ah you're right, we could do that, I hadn't thought of it.  Sounds
> cleaner than the $from/$to dance I did in this patch.

Usually simpler is better. The more complicated code, the more chances
for bugs, and less maintability. I haven't even tried to follow=20
$from/$to updating logic, but noticed that we can simply pass $from
and $to to build_projlist_by_category(), and use loop $from..$to there.

> > well, unless filtered out in print_project_rows() by $show_ctags; s=
o
> > I think that there is nonzero probability of empty (no project
> > shown) categories.
>=20
> Mh indeed, in fact this could happen any time we reach one of the
> 'next' statements in the loop in print_project_rows(), when performin=
g
> search, tag filtering, etc...
>=20
> Actually, assuming the project list is split into page, this can also
> lead to empty pages (if no project on the page matches the filter).
> To avoid empty categories, it's a bit tricky since the header is
> printed before we determine whether there are matching projects..
>=20
> I need to read the code more carefully, but it seems that one solutio=
n
> would be to add a function that determines whether a project should b=
e
> displayed or not (according to tags and search and forks); then we ca=
n
> map this function on the list of projects.
>=20
> I could do it if it sounds sane to you.

Nah, I think it would be best to postpone dealing with this issue, and
keep the code simple at the cost of possibly empty categories. It is
not as empty categories are an actual error...

I guess that correct way to deal with this would be to filter projects
earlier, before grouping by category, and not "at the last minute",=20
when displaying them. It might be even better solution wrt. dividing
projects list into pages. But that in my opinion is certainly matter
for a separate patch.

> > I'll try to examine the code in more detail later... currently I do=
n't
> > know why but I can't git-am the second patch (this patch) correctly=
=2E..
>=20
> This is the third patch, are you sure you applied 1 and 2 before?
=20
Somehow I couldn't apply second patch in series:

 $ git am -3 -u "[PATCH v3 2_3] gitweb: Split git_project_list_body in =
two functions.txt"
 Applying: gitweb: Split git_project_list_body in two functions
 error: patch failed: gitweb/gitweb.perl:3972
 error: gitweb/gitweb.perl: patch does not apply
 fatal: sha1 information is lacking or useless (gitweb/gitweb.perl).
 Repository lacks necessary blobs to fall back on 3-way merge.
 Cannot fall back to three-way merge.
 Patch failed at 0001.
=20
> Thanks for your careful and supportive comments!

You are welcome. Nice to have another gitweb developer :-)
--=20
Jakub Narebski
Poland
