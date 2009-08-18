From: "Adam Simpkins" <adam@adamsimpkins.net>
Subject: RE: interaction between --graph and --simplify-by-decoration
Date: Tue, 18 Aug 2009 13:55:54 -0700 (PDT)
Message-ID: <1250628954.114121983@192.168.1.201>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?UTF-8?Q?Santi=20B=C3=A9jar?=" <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Aug 18 23:06:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdVt8-0005zF-M0
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbZHRVGa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Aug 2009 17:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbZHRVGa
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:06:30 -0400
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:59908 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbZHRVG3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 17:06:29 -0400
X-Greylist: delayed 636 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Aug 2009 17:06:29 EDT
Received: from relay3.r3.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay3.r3.iad.emailsrvr.com (SMTP Server) with ESMTP id 473E044C0AA;
	Tue, 18 Aug 2009 16:55:54 -0400 (EDT)
Received: from dynamic7.wm-web.iad.mlsrvr.com (dynamic7.wm-web.iad.mlsrvr.com [192.168.2.148])
	by relay3.r3.iad.emailsrvr.com (SMTP Server) with ESMTP id 3B2EC44C02C;
	Tue, 18 Aug 2009 16:55:54 -0400 (EDT)
Received: from adamsimpkins.net (localhost [127.0.0.1])
	by dynamic7.wm-web.iad.mlsrvr.com (Postfix) with ESMTP id 1CC2B153806A;
	Tue, 18 Aug 2009 16:55:54 -0400 (EDT)
Received: by apps.rackspace.com
    (Authenticated sender: simpkins@adamsimpkins.net, from: adam@adamsimpkins.net) 
    with HTTP; Tue, 18 Aug 2009 13:55:54 -0700 (PDT)
Importance: Normal
X-Priority: 3 (Normal)
X-Type: plain
X-Mailer: webmail7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126457>

On Friday, July 31, 2009 4:11am, "Santi B=C3=A9jar" <santi@agolina.net>=
 said:
> Hello,
>=20
>   I've found that in some cases the --graph and
> --simplify-by-decoration don't work well together. If you do this in
> the git.git repository:

Thanks for reporting the problem, I apologize for taking so long to
investigate and respond.


> * | | f29ac4f (tag: v1.6.3-rc2) GIT 1.6.3-rc2
>  / /
> | | *   66996ec Sync with 1.6.2.4

> you can see that f29ac4f looks like it does not have any parents whil=
e
> the correct parent is 66996ec which seems to have no children. But if
> you omit the --oneline you can see that there are a lot of "root"-lik=
e
> commits (f01f109, a48f5d7, f29ac4f,...).

Yes, there's a bug in graph_is_interesting().  When processing
f29ac4f, the graph code thinks that 66996ec isn't interesting and
won't get displayed in the output, so it doesn't prepare the graph
lines to show lines to 66996ec.

I'll submit a patch shortly.

--
Adam Simpkins
adam@adamsimpkins.net
