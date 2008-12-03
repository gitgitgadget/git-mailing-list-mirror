From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gitweb: Optional grouping of projects by category
Date: Wed, 03 Dec 2008 14:51:07 -0800
Message-ID: <7viqq0c1pg.fsf@gitster.siamese.dyndns.org>
References: <87wsei1uvp.wl%seb@cine7.net>
 <200812030036.13562.jnareb@gmail.com> <87prk91got.wl%seb@cine7.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: =?utf-8?Q?S=C3=A9bastien?= Cevey <seb@cine7.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 23:52:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L80aC-000474-QJ
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 23:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630AbYLCWvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Dec 2008 17:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbYLCWvU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 17:51:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbYLCWvT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 17:51:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F117180B6;
	Wed,  3 Dec 2008 17:51:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 99C2518073; Wed, 
 3 Dec 2008 17:51:09 -0500 (EST)
In-Reply-To: <87prk91got.wl%seb@cine7.net> (=?utf-8?Q?S=C3=A9bastien?=
 Cevey's message of "Wed, 03 Dec 2008 15:22:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E51C9A36-C18C-11DD-A816-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102297>

S=C3=A9bastien Cevey <seb@cine7.net> writes:

> This adds the $projects_list_group_categories option which, if enable=
d,
> will result in grouping projects by category on the project list page=
=2E
> The category is specified for each project by the $GIT_DIR/category f=
ile
> or the 'category' variable in its configuration file. By default, pro=
jects
> are put in the $project_list_default_category category.
>
> Note:
> - Categories are always sorted alphabetically, with projects in
>   each category sorted according to the globally selected $order.

I am not sure if always sorting the categories alphabetically is a seve=
re
enough restriction, but if it was, you can use @project_list_categories
array that disables the feature when empty and otherwise enumerates the
categories in order.  Just an idle thought.

> - When displaying a subset of all the projects, only the categories w=
ith
>   projects in the chosen subset are displayed.

Could you clarify this bit?

It is not very clear to me how this subset selection happens.  As far a=
s I
can see, the user does not choose the category to view, but lets the us=
ual
page limiting to decide at which project to start and stop placing on t=
he
page, and only show the ones in the same category as the one that happe=
ned
to be the first on the page.

While I think both the introduction of "git_get_project_config_or_file"
which is a generalized interface usable between description and the new
feature and the refactoring of project_list_body into a seprate functio=
n
"print_project_rows" is a good idea, the patch would have been much eas=
ier
to read if these preparatory refactoring steps (without any new feature=
)
were done as a separate patch followed by the main patch to introduce t=
he
new feature.
