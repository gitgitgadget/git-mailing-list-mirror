From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] vcs-svn: Refactor dump_export code into dispatch
 table
Date: Tue, 01 Feb 2011 13:29:08 -0800
Message-ID: <7vd3nbzbob.fsf@alter.siamese.dyndns.org>
References: <1296570403-9082-1-git-send-email-artagnon@gmail.com>
 <1296570403-9082-4-git-send-email-artagnon@gmail.com>
 <20110201174241.GB3771@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 22:29:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkNnI-0005zu-5a
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 22:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab1BAV3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 16:29:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab1BAV3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 16:29:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 85B2A45E6;
	Tue,  1 Feb 2011 16:30:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Pnuu+P943a9j4NsdokJW5EqjzUw=; b=wXnwtASQjMid88c22+W9nRc
	i1SSAOKbskIkn6fcaZlM2kokhAKC0Mpmh7YpDCIIgNhHtdBmeEWGfPS8ijJCpeMZ
	/elWlENy06z56/x5JlVdWD3Prxh/KaeZMJgKnyDxLA+GEalNzl+m+gjn22X9BVPI
	O5d627yMfZNMvSvuhYDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=UauQ0CEF15cU/nxVX2B3/yT3+eWeBXsxZ/MUmIRvjaKDKrRDn
	z45I5FJb8zHUruzxBfYtg1dLpmWnK+w5XMMPTa2vgy4ExDzc/DVPzKLkav5K2rjI
	yHouD1qqmiBqL5oeX2mAHfcu3ZSHqyD451RAlUTUSYvj4+mY/CN6L4IS8A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 356C145E4;
	Tue,  1 Feb 2011 16:30:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9207D45E0; Tue,  1 Feb 2011
 16:30:01 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 71249980-2E4A-11E0-A04D-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165861>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Heh.  I think that Junio was suggesting making the _parser_
> table-driven, meaning something like
>
> 	... node_kinds[] = {
> 		{ "100644", sizeof("100644"), "file" },
> ...
> 	};

Yes, and thanks.
