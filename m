From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rename git_path() to git_path_unsafe()
Date: Wed, 16 Nov 2011 17:20:13 -0800
Message-ID: <7vzkfvo88i.fsf@alter.siamese.dyndns.org>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com>
 <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net>
 <7v7h31wduv.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com>
 <20111116075955.GB13706@elie.hsd1.il.comcast.net>
 <20111116080716.GE13706@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 02:20:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQqeP-00041G-4G
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 02:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116Ab1KQBUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 20:20:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37811 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754989Ab1KQBUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 20:20:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D58563EE;
	Wed, 16 Nov 2011 20:20:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tiRtJJ7tqLeMEeKvuygKy3y35+8=; b=bq3ctl
	7ODL7rps+6nrWHveqXj6OqC05L/gLSIsCspoBtgfOmzb+U1TMPMzO8BjgUha3xo9
	7p/r4BA5SE9lZncMrUp/0YH37BICVkj3lhDLPd8YhJ6lIr7Pvaed487/sDgSCzq2
	037XSJltAeBsS87/4soekina7rMfKRZ5FHU20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Om7+mc48YjnkMVv5QlqosU5/gLl1SqdM
	HA5/KfSGM1AahNz09QduD2JJnwLupI8u5aSHVuuerWnqSPUgraeJu5t2sE9LPdZT
	ZjaAQVbgL1CZG0aG8x+b4BsMKtfmMz85cJt4BQ/hTgi1JYY70oPvgfuNK2glMAej
	YvwzvXf2UY4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04DF463EC;
	Wed, 16 Nov 2011 20:20:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61B7C63EB; Wed, 16 Nov 2011
 20:20:15 -0500 (EST)
In-Reply-To: <20111116080716.GE13706@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Wed, 16 Nov 2011 02:07:16 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DDCF848-10BA-11E1-95B0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185567>

Given that other functions like real_path() and mkpath() share the same
"perishable, use it immediately" property, and also git_path() is such a
short and sweet name, I am beginning to think that we probably should
leave these alone but document that *path() are "unsafe" somewhere and
just add *path_cpy() or your strbuf_addpath() function.

In any case, I do not like seeing many list regulars throwing too many
non-regression-fix patches during prerelease freeze period on the
list. Continuing development for the next cycle is encouraged and trying
to do so using workflows that you do not usually use is even more
encouraged, though. You would make more use of the release candidate Git
for such activities, and may uncover regressions before the final.

Thanks.
