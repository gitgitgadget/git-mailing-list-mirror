From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/4] reachable.c: make reachable reflogs for all
 per-worktree reflogs
Date: Wed, 1 Jun 2016 17:51:31 +0200
Message-ID: <574F0483.80803@alum.mit.edu>
References: <574D382A.8030809@kdbg.org>
 <20160601104519.16563-1-pclouds@gmail.com>
 <20160601104519.16563-5-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	dturner@twopensource.com
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 17:51:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b88Qn-0001z7-FP
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 17:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbcFAPvh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 11:51:37 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:56508 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751116AbcFAPvg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 11:51:36 -0400
X-AuditID: 12074414-62bff700000008e6-c1-574f04865324
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 10.37.02278.6840F475; Wed,  1 Jun 2016 11:51:35 -0400 (EDT)
Received: from [192.168.69.130] (p508EAFFA.dip0.t-ipconnect.de [80.142.175.250])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u51FpVEI002094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 1 Jun 2016 11:51:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <20160601104519.16563-5-pclouds@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsUixO6iqNvO4h9uMGMqu8X8TScYLbqudDNZ
	PJl7l9mie8pbRosfLT3MDqweO2fdZfd4+KqL3eNZ7x5GjwXP77N7fN4kF8AaxW2TlFhSFpyZ
	nqdvl8CdsfTVFKaCFWwVz69JNDBOYu1i5OSQEDCR6Nq+i7GLkYtDSGAro8TqHY2sEM55Jokj
	G9rAqoQFoiW2/z7ADmKLCKRJLJ78nhnEFhJoZJQ4czMAxGYWiJPYsnwzE4jNJqArsainGcjm
	4OAV0JS4uBwszCKgIrHn5kM2EFtUIETi/LqtYON5BQQlTs58wgJSzilgLtF+2gJiorrEn3mX
	mCFseYnmrbOZJzDyz0LSMQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Vro5WaW
	6KWmlG5ihASyyA7GIyflDjEKcDAq8fBWXPYNF2JNLCuuzD3EKMnBpCTKW83sHy7El5SfUpmR
	WJwRX1Sak1p8iFGCg1lJhNfkp1+4EG9KYmVValE+TEqag0VJnPfbYnU/IYH0xJLU7NTUgtQi
	mKwMB4eSBK8oyFDBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UDTGFwPjESTFA7T3
	PSNQO29xQWIuUBSi9RSjMceCH7fXMnEc2X9vLZMQS15+XqqUOO97JqBSAZDSjNI8uEWwFPaK
	URzob2HefJB7eIDpD27eK6BVTECr4jN8QFaVJCKkpBoYBdZcSHW44R2Ve/9tfq3K2ZCXq57+
	Ef57qnaW+iajuh6ZjvdGiVcX3GBe4ylw3ftffOW5gKMXDxww/beH7+H62Osv718r 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296091>

On 06/01/2016 12:45 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
> [...]
> +void add_worktree_reflogs_to_pending(struct rev_info *revs, unsigned=
 flags,
> +				     struct worktree *wt)
> +{
> +	struct all_refs_cb cb;
> +	char *path;
> +
> +	cb.all_revs =3D revs;
> +	cb.all_flags =3D flags;
> +	path =3D xstrdup(worktree_git_path(wt, "logs/HEAD"));
> +	if (file_exists(path))
> +		handle_one_reflog(path, NULL, 0, &cb);
> +	free(path);
> +	path =3D xstrdup(worktree_git_path(wt, "logs/refs/bisect"));
> +	if (file_exists(path))
> +		handle_one_reflog(path, NULL, 0, &cb);
> +	free(path);
> +}

`refs/bisect` is not a single reference. It is a namespace that contain=
s
references with names like `refs/bisect/bad` and
`refs/bisect/good-66106691a1b71e445fe5e4d6b8b043dffc7dfe4c`.

> [...]

Michael
