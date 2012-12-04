From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] fsck: warn about ".git" in trees
Date: Tue, 04 Dec 2012 11:40:06 +0100
Message-ID: <50BDD306.30301@op5.se>
References: <20121128213529.GA16518@sigill.intra.peff.net> <50B90E11.8090501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 04 11:40:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfpvR-0001b0-7t
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 11:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab2LDKkN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2012 05:40:13 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:60398 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2LDKkL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2012 05:40:11 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so1535775eaa.19
        for <git@vger.kernel.org>; Tue, 04 Dec 2012 02:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=Ak3Zi0y9zbhN8z+o5BNCogpQkgf8J+zSN2Qh5Xe13K4=;
        b=GhU2uJ9bNlh0peMRMdyW+IMxcJUo6Xpy3yW5Goz6SpBQgzPp5sFE2l4PTgU4ZnQcjc
         BMi+Gpj9GL0iw0LSpWf5/BXsqhfpGOdRBBe/KHKbHHaTfWJI4/a3oR0J7l1MziGCXWvP
         kUmcAfdOX8xx0v1sOVs1z6z4BpBKUH+XplT0kDI3bHAdKusjtKBS6DcK9E7xKyAIOaeO
         mO035zsl0FZ/VLAod/RStOdojOunRjg8sFgHbf+E6z7plxqWiI1EVJPuwe/FNNn3t3YG
         IraNfu+ahD8OWWrE1JxJXMOBtM9KF/ZQZQXXqyVwoA3Ic+uSvxgvraMFpG3MZBLqDKBM
         HmzQ==
Received: by 10.14.175.133 with SMTP id z5mr47233928eel.15.1354617610473;
        Tue, 04 Dec 2012 02:40:10 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id z8sm1825342eeo.11.2012.12.04.02.40.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 02:40:09 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50B90E11.8090501@web.de>
X-Gm-Message-State: ALoCoQnV70NlkWT1ocBzAUloiFfLxJkb7N/0izvHHV0ajaS4AFylYXjV6ZVoI7SdwJg91I/GncbR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211078>

On 11/30/2012 08:50 PM, Torsten B=F6gershausen wrote:
>> Having a ".git" entry inside a tree can cause confusing
>> results on checkout. At the top-level, you could not
>> checkout such a tree, as it would complain about overwriting
>> the real ".git" directory. In a subdirectory, you might
>> check it out, but performing operations in the subdirectory
>> would confusingly consider the in-tree ".git" directory as
>> the repository.
> [snip]
>> +    int has_dotgit =3D 0;
>=20
> Name like "." or ".." are handled as directories by the OS.
>=20

The patch is for the index, where they're handled as whatever the mode
claims it is. The patch doesn't touch those parts though.

> ".git" could be a file or a directory, at least in theory,
> and from the OS point of view,
> but we want to have this as a reserved name.
>=20
> Looking at bad directory names, which gives trouble when checking out=
:
>=20
> Should we check for "/" or "../blabla" as well?
>=20

Apart from the checks already in place, checking for git's internal
directory separator marker (which is '/') is enough to catch both,
and that check is done.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
