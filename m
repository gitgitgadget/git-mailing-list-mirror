From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Import wildmatch from rsync
Date: Tue, 02 Oct 2012 11:26:30 -0700
Message-ID: <7vfw5w91d5.fsf@alter.siamese.dyndns.org>
References: <1348658741-8146-1-git-send-email-pclouds@gmail.com>
 <1348658741-8146-2-git-send-email-pclouds@gmail.com>
 <CACBZZX6CLZAcUG2GjBt4brF9dGr1Zvj1HMTV=U-AXFZhzR=39Q@mail.gmail.com>
 <CAHSx_SsnSAV7SVLRnAFvS7AmdRgPkPX3NEM+6HTjfW5r8hXeig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Wayne Davison <wayned@samba.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 20:26:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ7B8-0005ke-BJ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 20:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174Ab2JBS0g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2012 14:26:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37067 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883Ab2JBS0f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2012 14:26:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE4B49473;
	Tue,  2 Oct 2012 14:26:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=q6XjiTKTEwIJ
	tC+N8gmEn/tItlw=; b=J5CzgD0Mr0b48PNdFBs4fy/dznDp6YKs8zVIkbsnMRfi
	Ttb527z69aLs6G92a2svW91ggLLEUyrOkf3PXkT5izxI8pr7CogYMB1oQwED98TI
	3TqxpildT6+/m+gUVMnRbuIEBB8JEvsSYQYipcA6hIhjiVN4iNXvK5lAtd9WTck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=exfA2t
	jRIYGs4ObH9AIqfp3kbxsRpSK6Pe0sbP1spITuecQQcXkYXKyf010grgPT9SHj4V
	z271BVphb5mfBkZtl6gMiDUgZ0ZXxUGbIv49C7KkOL1jS6WgKPBmSKH5wsED8Sew
	1kWoFrrw1D+4rHsN8x6viInc6R14mVXXRrauk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAFAB9472;
	Tue,  2 Oct 2012 14:26:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37DC19471; Tue,  2 Oct 2012
 14:26:32 -0400 (EDT)
In-Reply-To: <CAHSx_SsnSAV7SVLRnAFvS7AmdRgPkPX3NEM+6HTjfW5r8hXeig@mail.gmail.com> (Wayne
 Davison's message of "Tue, 2 Oct 2012 11:16:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0B2EDA0-0CBE-11E2-A959-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206829>

Wayne Davison <wayned@samba.org> writes:

> On Tue, Oct 2, 2012 at 7:07 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n <avarab@gmail.com>wrote:
>
>> Perhaps Wayne Davison (added to CC) wouldn't mind giving us permissi=
on to
>> use the subsequent changes to these files under the GPLv2?
>
> There have been no changes in the wildmat files since the GPL v3
> changeover.  If there were (and I made them), I'd have been happy to =
let
> you have them under GPL v2.

Super ;-)

Thanks.
