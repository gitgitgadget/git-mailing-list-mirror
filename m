From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 05/11] column: support columns with different widths
Date: Sun, 26 Feb 2012 15:12:00 -0800
Message-ID: <7v62etdwan.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330170078-29353-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 00:12:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1nGF-0002YQ-47
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 00:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038Ab2BZXME convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Feb 2012 18:12:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830Ab2BZXMC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2012 18:12:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90AF87540;
	Sun, 26 Feb 2012 18:12:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6lj6acywU0Ft
	OQ7wfGPkjKZFCCQ=; b=fxg6JbG6SEpFfq3blYP6ZOq9PmI6/W7JH9RfG+WAQ+jv
	lEPfX6xArFf0eqU0DV7iCk5NYS+CAB7SK7akyRq4Yq/RTMDsE6whZjrJbHJToqa9
	9vrqfxgaj2mYNBXda7CD6R48uUVINov5i2WOa61l1fqGr/U+NQ50VJIatLe3Zyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Kdafww
	eCGeilgGWsED0ILFA/XgC/rxqhsdgyoN377dS1RubXZLSoEAo+W8nY7c3QZruMi5
	JGljYBYjwcH9lUQSYdph0YbKZAaP3GHe/zvU8dmXL4ex4e+JFFDNDrCbhK4zcGrd
	ogpJu5roik2l09txE5Dy3kgCT65pBOJ1QdiXU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87923753F;
	Sun, 26 Feb 2012 18:12:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1427753E; Sun, 26 Feb 2012
 18:12:01 -0500 (EST)
In-Reply-To: <1330170078-29353-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 25 Feb
 2012 18:41:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A5DE91A-60CF-11E1-ABF8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191582>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

The contrast between this and the previous one is striking.

The addition of MODE_COLUMN and MODE_ROW are very well explained, and i=
t
will help people to later learn how to use the columns subsystem in the=
ir
programs.  But this does not even mention what "different widths" is, l=
et
alone explaining how to use it or if it is always on and the programs d=
o
not have to worry about (and have no control over) its behaviour.

I am guessing from the patch that you can tell the column subsystem to =
use
a different mode, just like you can use MODE_COLUMN or MODE_ROW to inst=
ruct
column/row major ordering, by using MODE_DENSE or something.

I am also reading from the patch that the "dense mode" allocates minimu=
m
necessary width dynamically to columns, which end up having different
width.  So "different" is not the more important part; "dense" is.

But the reader should not have to guess these things.
