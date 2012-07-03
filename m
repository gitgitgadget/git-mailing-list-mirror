From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] gitweb: Handle a few other tags in git_print_log
Date: Tue, 03 Jul 2012 13:05:02 -0700
Message-ID: <7v3958vcep.fsf@alter.siamese.dyndns.org>
References: <1341295377-22083-1-git-send-email-namhyung@kernel.org>
 <1341295377-22083-3-git-send-email-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Namhyung Kim <namhyung.kim@lge.com>
To: Namhyung Kim <namhyung@kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 22:05:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm9LY-0000aa-Sf
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 22:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757114Ab2GCUFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 16:05:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60652 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000Ab2GCUFF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 16:05:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 835959165;
	Tue,  3 Jul 2012 16:05:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=erKKK9c1PgljyW81y0SUyojqniE=; b=PSDcjC
	DYLvS94/BVNMF2Zu1lZNjk/hVL3ojWmmPl7a58O+ti23lDGI9kSDI2JY4mcy99ZR
	h42l85pTq+zGLXxpZeex81s4gmtUNn6rIi1Tqj8Gs/IXKwyPOmDAYLabtFsTbCx2
	zcAXJ9h5sL1UjsaAygvX0jUtHBKswQs+0FAZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SQdtSQNMkuxRtuRPLuajGBI51Wz4rIOf
	SIZjpOey49UDbWi5jJyNWLzv+thcEjQn6IOEPdhuTjmWsKiq4+DxnGyBPs6Xwnw0
	QIPcp4/6khLEDln//ywQF6iVXu9d3LZYFKxpkkrcsNBgKoR3LQj/gfEPrWjMTzfi
	w0sCmksjY8c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 793629164;
	Tue,  3 Jul 2012 16:05:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED05C9163; Tue,  3 Jul 2012
 16:05:03 -0400 (EDT)
In-Reply-To: <1341295377-22083-3-git-send-email-namhyung@kernel.org>
 (Namhyung Kim's message of "Tue, 3 Jul 2012 15:02:56 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60C85728-C54A-11E1-BEDA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200940>

Namhyung Kim <namhyung@kernel.org> writes:

> There are many of tags used in s-o-b area. Add
> support for a few of well-known ones.
>
> Signed-off-by: Namhyung Kim <namhyung.kim@lge.com>
> ---
>  gitweb/gitweb.perl |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7585e08..e0701af 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4485,8 +4485,9 @@ sub git_print_log {
>  
>  	# print log
>  	my $empty = 0;
> +	my $tags = "acked|reviewed|reported|tested|suggested"

Missing ';' at the end.

>  	foreach my $line (@$log) {
> -		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
> +		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|($tags)[ \-]by[ :]|cc[ :])/i) {

Is anybody actually helped by these spaces that make the regexp
unnecessarily cluttered?

I am very tempted to suggest doing something like this:

	my $tags = join('|', qw(signed-off acked reviewed reported tested suggested));
	for my $line (@$log) {
		if ($line =~ m/^\s*(?:(?:$tags)-by|cc):/i) {
			...

or even this:

	for my $line (@$log) {
		if ($line =~ m/^\s*(?:[a-z][-a-z]*[a-z]): /i) {
			...
