From: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@mit.edu>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Tue, 05 Apr 2011 16:25:02 -0400
Message-ID: <4D9B7A9E.6040902@mit.edu>
References: <4D9B310A.9020203@mit.edu> <1302034509-8842-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	James Y Knight <jknight@itasoftware.com>,
	Junio C Hamano <gitster@pobox.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Apr 05 22:33:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Cvy-000320-Is
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 22:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937Ab1DEUdA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 16:33:00 -0400
Received: from mx2.itasoftware.com ([63.115.78.21]:50888 "EHLO
	mx2.itasoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873Ab1DEUc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 16:32:59 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Apr 2011 16:32:59 EDT
Received: from ita4mta2.internal.itasoftware.com (ita4mta2.internal.itasoftware.com [10.4.52.168])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.itasoftware.com (Postfix) with ESMTP id D867957D48;
	Tue,  5 Apr 2011 16:26:59 -0400 (EDT)
Received: from asedeno.corp.itasoftware.com (lb1.dc4nat129.dc4.internal.itasoftware.com [10.4.199.129])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ita4mta2.internal.itasoftware.com (Postfix) with ESMTPS id 7791D19D8031;
	Tue,  5 Apr 2011 16:25:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110309 Icedove/3.1.9
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1302034509-8842-1-git-send-email-asedeno@mit.edu>
X-ITASoftware-MailScanner: Found to be clean
X-ITASoftware-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=0.207, required 3, ALL_TRUSTED -1.00, MISSING_HEADERS 1.21)
X-ITASoftware-MailScanner-From: asedeno@mit.edu
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170910>

On 04/05/2011 04:15 PM, Alejandro R. Sede=C3=B1o wrote:
> @@ -730,7 +736,11 @@ sub cmd_branch {
>  		$url =3D eval { command_oneline('config', '--get',
>  			"svn-remote.$gs->{repo_id}.commiturl") };
>  		if (!$url) {
> -			$url =3D $remote->{url};
> +			$url =3D eval { command_oneline('config', '--get',
> +				      "svn-remote.$gs->{repo_id}.pushurl") };
> +			if (!$url) {
> +				$url =3D $remote->{url};
> +			}
>  		}
>  	}
>  	my $dst =3D join '/', $url, $lft, $branch_name, ($rgt || ());

Actually, I was just finishing running this through its paces with
different values for url and pushurl, and branching has issues:

Trying to use an unsupported feature: Source and dest appear not to be =
in
the same repository (src: 'http://asedeno/svn/trunk'; dst:
'file:///tmp/svn/repo/branches/nb1') at /tmp/git/libexec/git-core/git-s=
vn
line 770

So I'm continuing to look into that. Perhaps it makes sense to use push=
url
for both src and dst when branching?

-Alejandro
