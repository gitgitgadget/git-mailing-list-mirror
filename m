From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: forbid --bare --separate-git-dir <dir>
Date: Sun, 06 Jan 2013 15:13:19 -0800
Message-ID: <7v6239nbw0.fsf@alter.siamese.dyndns.org>
References: <20130106091642.GA10956@elie.Belkin>
 <1357465670-32766-1-git-send-email-pclouds@gmail.com>
 <20130106101948.GD10956@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 00:13:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrzPR-0008Sj-R1
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 00:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab3AFXNX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 18:13:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228Ab3AFXNW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2013 18:13:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D57C4A8E8;
	Sun,  6 Jan 2013 18:13:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MEWh9dZCEFxl
	5DZIFAmZPdhUqYM=; b=ao2Q6dShpjOk9Sl2SZ45k6kUZDAonsc4uWIeDV2dFW7y
	ULBnEU7dBgihbTWYP7Dgr35vt/idfs9AwBWG+6jBz1qdjksV8fQxevMm4KP09z/a
	PM0erGnenUxe63F1wesuanBBSSGC4TYUhSVjsxqDMYAvke4klvUkP1S2udYVZEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=g9Ysqy
	OTyKdHTW4lSd7LwMR638HVW66vlSIkdpimvdJmrn+gqV9ax0R6FwvCmIEPTzspxK
	yvONveDn0i2N3hBfMqYvE8fjDd//xUzl1qt/tSdQfdVlTSvml0zNz0VapdiceLbe
	8E4jBvU7wf+n1ee45LwfqsnbsxPh2tQ9OjRd4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0F64A8E7;
	Sun,  6 Jan 2013 18:13:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14D82A8E6; Sun,  6 Jan 2013
 18:13:21 -0500 (EST)
In-Reply-To: <20130106101948.GD10956@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 6 Jan 2013 02:19:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9A83018-5856-11E2-8831-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212855>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> --separate-git-dir was added to clone with the repository away from
>> standard position <worktree>/.git. It does not make sense to use it
>> without creating working directory.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>
> The patch correctly implements the above.  The description leaves out
> detail.  I'd say something like
>
> 	The --separate-git-dir option was introduced to make it simple
> 	to put the git directory somewhere outside the worktree, for
> 	example when cloning a repository for use as a submodule.
>
> 	It was not intended for use when creating a bare repository.
> 	In that case there is no worktree and it is more natural to
> 	directly clone the repository and create a .git file as
> 	separate steps:
>
> 		git clone --bare /path/to/repo.git bar.git
> 		printf 'gitdir: bar.git\n' >foo.git
>
> 	Unfortunately we forgot to forbid the --bare
> 	--separate-git-dir combination.  In practice, we know no one
> 	could be using --bare with --separate-git-dir because it is
> 	broken in the following way: <explanation here>.  So it is
> 	safe to make good on our mistake and forbid the combination,
> 	making the command easier to explain.
>
> I don't know what would go in the <explanation here> blank above,
> though.  Is it possible that some people are relying on this option
> combination?

I do not necessarily think we must say "it happens not to work
already for such and such reasons, lucky us!", but it is indeed a
good idea to think things through, justifying why this cannot be a
regression, and record the fact that we did that thinking, in the
log message.

Thanks.
