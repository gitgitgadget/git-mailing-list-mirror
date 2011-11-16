From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] avoiding unintended consequences of git_path() usage
Date: Wed, 16 Nov 2011 14:04:06 -0800
Message-ID: <7v1ut7rag9.fsf@alter.siamese.dyndns.org>
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
 <CACsJy8Di3ZrPdXh1Jf=PbLYRWwx-TEV78NzUukwaxA0xW=rSNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 23:04:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQnaa-0008FM-Ip
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 23:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab1KPWEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 17:04:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34620 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383Ab1KPWEK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 17:04:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD2395E5D;
	Wed, 16 Nov 2011 17:04:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hR1LeUGtHElBieDYnLVziZ0rV1A=; b=wbmo/Q
	yI1KxozGCTGQD/FXCdt+xDI7O3hnflT8TqZZQ8he9z6FQC7z1EcjiopJdVd7QYs1
	uooGiDYIaiXXI9/osSEHfdnqsCgrXhakSwHwCVgJcaNM2YQiQYsq5tN9rGJGQM/F
	SDuBHZFdkW/Bypf8LdMIOpYvpPTjZ9oyg3aXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i08xUFKKAkRAjl3NjvJ4KNRu+SZgKh6C
	9rZ3V0LzRhaSCL+DOX+Cn0DwgadSIdULAm4sLkVLixONL/oskJmzgy3MqQIg/etV
	7RpBA+02WZj8PIMyB+G98TYnGttJFD0FgcIDdBpABLcHUV6ZR7/ZAmz1f2oXO45T
	OvCAIz7WFc4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B44CC5E5B;
	Wed, 16 Nov 2011 17:04:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CEAC5E51; Wed, 16 Nov 2011
 17:04:08 -0500 (EST)
In-Reply-To: <CACsJy8Di3ZrPdXh1Jf=PbLYRWwx-TEV78NzUukwaxA0xW=rSNg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 16 Nov 2011 15:37:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E80EB972-109E-11E1-BD24-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185556>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> ... git_path() could learn to keep track
> of all generated strings while keep it convenient to use.

That certainly sounds an interesting approach.
