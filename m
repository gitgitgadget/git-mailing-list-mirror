From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: allow to specify diff pathspec in addition to prune
 pathspec
Date: Fri, 04 Nov 2011 15:07:59 -0700
Message-ID: <7vsjm3a6dc.fsf@alter.siamese.dyndns.org>
References: <1320314474-19536-1-git-send-email-pclouds@gmail.com>
 <1320322556-32675-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 23:08:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMRvk-0007AH-Qj
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 23:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab1KDWID convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 18:08:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764Ab1KDWIC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2011 18:08:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A83775973;
	Fri,  4 Nov 2011 18:08:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bJ6jZZIXfomy
	ZIkNMCPRdHvM5sA=; b=BHtyiy8UJRWOT44q9TUUtvelejvtY8ezd4rc7jwksgZu
	FcVSn6iW7drZxMTZ6DONUMIQDB18PIN6QfPDBvVJHLM553oWmcshmeMvNHkzPUi8
	3G3pt4PsuDNK8PTKqtgw0sTMv0d5FiB8EuQTH1usxy55o2qWu78JBBcpcTmt8GA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KySa5U
	f996lTwGHvzrBOpN6U8/Cf8dnYInIG8CM5AZA8cMcwHxiP+6CIKBWYDcCM9T51q7
	4vBsCa0ZEGqL6EalZGdPZZIfl3ouYDnaSOLtydyaZ4hdGr/726ZCL+pd63ocYPYm
	ESkeKkC7MdH0pgv3FB7ewPuqPc91HK0YWTWEQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88CB1596C;
	Fri,  4 Nov 2011 18:08:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A906D5966; Fri,  4 Nov 2011
 18:08:00 -0400 (EDT)
In-Reply-To: <1320322556-32675-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 3 Nov
 2011 19:15:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75AF1C3A-0731-11E1-BF38-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184807>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This form requires specifying "--" twice. If a file name happens to b=
e
> "--", it may be misunderstood as the second "--" marker. This is an
> unfortunate consequence for this syntax. Users can still use "./--" o=
r
> similar to workaround this.

This is not a new "problem" (and it is probably not a problem to begin
with).  If you had "--" in the working tree and you wanted to treat it =
as
a path, you said either one of these:

    $ git log HEAD ./--
    $ git log HEAD -- --

The latter is what your patch breaks, I suspect.

Also it forces existing scripts and programs that knew "everything in t=
his
array is a pathspec" and added "--" before adding the contents of the
array to form a command line to drive "git log" family of commands to b=
e
updated.
