From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] submodule groups
Date: Wed, 11 May 2016 16:39:08 -0700
Message-ID: <xmqqlh3gi2qr.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<xmqq4ma5l526.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY3S6SmJOMQ7RAKw0yTvicY=Y1VRRGdm5uK9+Eb7W+Ykg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 12 01:39:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0dim-00060w-DK
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 01:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbcEKXjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 19:39:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751830AbcEKXjM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 19:39:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB7CD1BEEE;
	Wed, 11 May 2016 19:39:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gtdkZ1YlblDXGJhr+V+T4WaY7eA=; b=SqEeEg
	gI9/lvrXTjU2WOPEyt5HNuMlKMkX/GtIfbDjldOxyizetaxmn8AdplU0G3fkc/ST
	yPT4B6HwM3gLtZHMWEtWOfSikC02uNzmszrNCAlMzAkX3hL9w/fPkKi67yeGCM/z
	plsQn7F67sVD7z1VbKrphloNjoE0xDht1S2/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fVhXgEIu+9/cBZboTpV0hBrs1A50L88e
	wXVFcdz4qqAuVxn/4NX6/tfBIYIqZhWnp7mUo56YieJapj8tWWiB2KJ5C63YRR3y
	82ZTT22w1bSDx0DrfTwGUnJV3sjs2DAnGKUWPBG5Zp/w9/W3VnHTDtgrncHRTQLm
	5EWEQN6Vq0k=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D358B1BEEB;
	Wed, 11 May 2016 19:39:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B52E1BEEA;
	Wed, 11 May 2016 19:39:10 -0400 (EDT)
In-Reply-To: <CAGZ79kY3S6SmJOMQ7RAKw0yTvicY=Y1VRRGdm5uK9+Eb7W+Ykg@mail.gmail.com>
	(Stefan Beller's message of "Wed, 11 May 2016 16:07:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8F6C06A0-17D1-11E6-A008-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294378>

Stefan Beller <sbeller@google.com> writes:

> So I wonder if we rather want to extend the pathspec magic to
> include properties of blobs (i.e. submodules):
>
>     git <command> . :(sub-label:label-sub0) :(exclude)*0
>
> would look much more powerful too me. Properties of blobs
> may also be interesting for otherwise. Imagine looking for huge files
> (in a bare repo, so you have to use Git and not your shell tools):
>
>   git ls-files . :(file-size:>1024k)

I somehow do not think this is a way normal people (read: end users)
would want to interact with Git.  Pathspec is about "paths" and
various ways to match them.  It is not about contents that happens
to be currently named by that path.  Don't tie types or sizes to it.
