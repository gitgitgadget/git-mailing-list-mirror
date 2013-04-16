From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/13] pretty: support padding placeholders, %< %> and
 %><
Date: Tue, 16 Apr 2013 13:41:33 -0700
Message-ID: <7v1uaaky2q.fsf@alter.siamese.dyndns.org>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 22:41:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USChD-0008Fd-AH
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 22:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965288Ab3DPUlh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 16:41:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48561 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965099Ab3DPUlg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 16:41:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04B2B16E30;
	Tue, 16 Apr 2013 20:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NGIE0w0YfiXF
	3aavjPMeEqj5tJ4=; b=uZWAfOnyLBkDuw3xqcd8wnImEA1GFCRkCdSOZz5XD0mJ
	pKjePh1DKddLnf84uEz6jLmqikVxEjpgQDejTrNdp20VZKr2ThT46kjH3Ov+aKaI
	JyWRnAOru/Z6TojxYd9VIaKKu4FcLChcpRZDvQ1WjDHV0yW4XE+5OViToHnKFpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cf+Sk3
	Sfk2KUwtiv5k5FMX9DToUBVpWTT5LzWN8qbXymo/txFlBUJpLiQyfx87VAV9xD0q
	Ecx4TrBczwrtSyWonEgp0X++AfsUm9cZAJVJNbSmjvRVLWLOWXRVdQZfFZnDjxzc
	ch8wsktp990AeyLDeUKqglv41wXvB9uip0oBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED47816E2F;
	Tue, 16 Apr 2013 20:41:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DA3316E2C; Tue, 16 Apr
 2013 20:41:35 +0000 (UTC)
In-Reply-To: <1366100702-31745-12-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 16 Apr
 2013 18:25:00 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 078F86CC-A6D6-11E2-A72F-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221466>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +delete_trailing_dollar() {
> +	sed 's/\$$//'
> +}

This is what we have qz_to_tab_space for, isn't it?  With it, you
can not just avoid "trailing whitespace", but also "indent with
spaces", like this:

Q         message thousand    Z
