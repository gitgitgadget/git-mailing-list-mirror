From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-send-email.perl: make initial In-Reply-To apply
 only to first email
Date: Wed, 10 Nov 2010 11:48:55 -0800
Message-ID: <7v62w5hsd4.fsf@alter.siamese.dyndns.org>
References: <20101020004533.b64d446c.ospite@studenti.unina.it>
 <1288990769-13307-1-git-send-email-ospite@studenti.unina.it>
 <vpqtyjvo0tp.fsf@bauges.imag.fr> <7vy692kx8k.fsf@alter.siamese.dyndns.org>
 <20101110124522.0dff4076.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Wed Nov 10 20:49:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGGfl-00079o-LH
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 20:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756795Ab0KJTtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 14:49:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756783Ab0KJTtS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 14:49:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A54C3626;
	Wed, 10 Nov 2010 14:49:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pJoGmq2ojyEFVWQIQhNZNU2Y6Gs=; b=ibF+Jc
	g4/FvsXYZvh6POg5YKj+ZUkJqLye16GmJJwuBYAHKoCCNM2r/RBYXokMs5HX2ysu
	3K/Ca5Xc5Mr/l315+NQUJLT6DgDvWbTaCEdrgyVGVRQb3VhSTjTdjfAGhJtZINtm
	H3YloCduoy0fAAZRN4bDaBi2CDWhBGpVrvIFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qABDL+miDI8xbPMhJESKEeEce30DnVrw
	tfn0/8Uw2fH9Y65JWMeOT31Eq3CHL2FjWpawpQlLoKJEYTk5EQ/qLhmEXzDxVRLq
	TisUwfh7EVgFap1uG+DZsD2ByVbid2YOmjOAlOM9y7tb3apD+mdptSTY6RDkh9Vd
	ORGen3n/pUc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B68F3623;
	Wed, 10 Nov 2010 14:49:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E46D7361F; Wed, 10 Nov 2010
 14:49:00 -0500 (EST)
In-Reply-To: <20101110124522.0dff4076.ospite@studenti.unina.it> (Antonio
 Ospite's message of "Wed\, 10 Nov 2010 12\:45\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 968A29B6-ED03-11DF-8414-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161176>

Antonio Ospite <ospite@studenti.unina.it> writes:

> ... About the tests, I am going to modify one of your
> tests instead of adding another one, is that OK?

It is not just Ok but is preferred; that is a good way to document where
the behaviour changed how, and for what reason ;-).

Perhaps an illustration in the documentation may help.  Until I read what
Matthieu wrote in his message, I didn't quite get why anybody wanted this
new behaviour---my understanding of which is to get something like this:

    [PATCH 0/2] Here is what I did...
     [PATCH 1/2] Clean up and tests
     [PATCH 2/2] Implementation
     [PATCH v2 0/3] Here is a reroll
      [PATCH v2 1/3] Clean up
      [PATCH v2 2/3] New tests
      [PATCH v2 3/3] Implementation

when sending the re-rolled series, with the --in-reply-to for [v2 0/3] set
to [0/2] of the original.  If you illustrate the current behaviour in a
similar way in your commit log message, perhaps side-by-side to save
vertical space, it would help make it clear why people would want the new
behaviour.
