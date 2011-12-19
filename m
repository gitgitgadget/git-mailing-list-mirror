From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4018: introduce test cases for the internal hunk header
 patterns
Date: Mon, 19 Dec 2011 14:37:54 -0800
Message-ID: <7vty4wkx19.fsf@alter.siamese.dyndns.org>
References: <20111217012118.GB20225@sigill.intra.peff.net>
 <31E9klcRboMV0wSJY5WO-N7nIBOUOa_wr6MVfWY9AInImxJIqC0flahvpDrVGMIuZ9e7Ouha1HDuesbwTGaNQA4dgN-FShNJKkfMG_cHLUJAT2rE539shnQxzM0dQyZIb5661As6Tvs@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, git@vger.kernel.org, j6t@kdbg.org,
	jrnieder@gmail.com, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Dec 19 23:38:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RclqM-0003r2-Pd
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 23:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096Ab1LSWh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 17:37:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827Ab1LSWh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 17:37:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0313E731A;
	Mon, 19 Dec 2011 17:37:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7ekzj3TqZ+g1T7XId3cJJGTIy1Q=; b=jStp8X
	uNq4o9f/WHxtI3OD/NTj8HkVEY/GyHmxEHGCni/jNWeBVJJxY9F4ioNke5qnbMFM
	sYtuiNTV5bid7XJwgYSo6DsWDQgP7BbjwKLGIQG9zIecUoXs+3goO57D3G+9HoQb
	tFzN0ETkqMId0M6ACFl6gvVhPeDTfXuLZrjLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x2VCpjrRTr1xEp8/Ni+Ie2PKE9XvmZum
	YxLeP0qiv5ERLaVvbcP2c69czCRCx0aj79O4Wq1FhBQO/hHXrFKVzgo5mnhca48b
	ViLtE7PbD2YddWQ5JKTasfjDtAvp71Ck14tVUBP7GAzNE0DO3907tCR7KpRH8VdQ
	L3sOSaAUIoU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED87C7319;
	Mon, 19 Dec 2011 17:37:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4421B7318; Mon, 19 Dec 2011
 17:37:56 -0500 (EST)
In-Reply-To: <31E9klcRboMV0wSJY5WO-N7nIBOUOa_wr6MVfWY9AInImxJIqC0flahvpDrVGMIuZ9e7Ouha1HDuesbwTGaNQA4dgN-FShNJKkfMG_cHLUJAT2rE539shnQxzM0dQyZIb5661As6Tvs@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Mon, 19 Dec 2011 14:52:26 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1886DBA4-2A92-11E1-9187-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187481>

Brandon Casey <casey@nrlssc.navy.mil> writes:

>    * new test cases can be dropped into the t4018 directory
>    * filenames end with the pattern name e.g. .cpp .objc .matlab etc.
>    * filenames should be descriptive since it will be used in the test
>      suite output
>    * broken test cases should be given a filename prefixed with "broken_"

Cute. I like the general idea.

>    * test cases must provide a function named "RIGHT_function_hunk_header"
>      - this is the function name that should appear on the hunk header line
>      - the body of this function should have an assignment like
>
>           answer = 0
>
>        The test suite will modify the above line to produce a difference
>        from the original.  Additionally, this should be far enough within
>        the body of the function so that the function name is not part of
>        the lines of context.

Although I do not think of any language with a syntax rule where that the
overlong RIGHT_func... token is an illegal symbol offhand, this feels a
bit _too_ specific to the C language. I would prefer something like this
instead:

    * a test case must have one (and only one) line that contains "RIGHT"
      (all uppercase) and that line should become the hunk header for the
      test to succeed.

    * after the line that contains "RIGHT" token, there should be one (and
      only one) line that contains "ChangeMe". The test modifies this
      token to "IWasChanged", compares the original with the modified
      result, and expects the "RIGHT" token above appears on the hunk
      header.

Also I would prefer not to require "enough filler", as we might want to
enhance the logic to consider using a line in the pre-context as the hunk
header in some cases, e.g.

    @@ ... @@ int RIGHT_function_hunk_header(void)

     int RIGHT_function_hunk_header(void)
     {
    -    int ChangeME;
    +    int IWasChanged;
         printf("Hello, world\n");
	 return 0;
     }
    @@ ...
