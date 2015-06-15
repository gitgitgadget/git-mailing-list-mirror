From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] upload-pack: Fail if cloning empty namespace
Date: Mon, 15 Jun 2015 13:49:38 -0700
Message-ID: <xmqqh9q87l3x.fsf@gitster.dls.corp.google.com>
References: <1434140115-3139-1-git-send-email-johannes@kyriasis.com>
	<1434147436-21272-1-git-send-email-johannes@kyriasis.com>
	<20150612223223.GA22677@leeloo.kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes =?utf-8?Q?L=C3=B6thberg?= <johannes@kyriasis.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 22:49:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4bKE-0006A8-SI
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 22:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124AbbFOUto convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2015 16:49:44 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33031 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbbFOUtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 16:49:40 -0400
Received: by iebgx4 with SMTP id gx4so246914ieb.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 13:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=sF8q3ezFbbeesiW72IdiHFWnQ8wQMrnOzDvYbrOsw+Q=;
        b=MiK5GPwpzgZwRDzYcjrF5+5lF4lPyJ3FA9WKMoGyoQdDL7dfTHHRIITZNLaovCRV/l
         k7REVWksng9DFeuCbPlXPbA/Iothm2fWCqfGWBO4Op0d8821SDePG+Jasl+UdDbhrWei
         JAYb/bG4sBnoDbZXBTLcCvcgwFpdIqGYo5JNzPQPd889oSmgkZwoQDJw/z4Ur/IhZokV
         NMZgraSgYNYZCCO/3oOc8gwwFnxgh+JV/OLfpdWCwsAmYpjmbURkWNC9uwphh7WQeui+
         dqogCd4yN9yqTJWELG8DD1l8L8NHKG0NHab253Ciu1Bcowg+QnYkeyhDZ9LDJ1GFFiCk
         OMsQ==
X-Received: by 10.50.132.3 with SMTP id oq3mr23241193igb.21.1434401380232;
        Mon, 15 Jun 2015 13:49:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id 137sm9616967ioo.29.2015.06.15.13.49.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 13:49:39 -0700 (PDT)
In-Reply-To: <20150612223223.GA22677@leeloo.kyriasis.com> ("Johannes
	=?utf-8?Q?L=C3=B6thberg=22's?= message of "Sat, 13 Jun 2015 00:32:23
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271727>

Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:

> On 13/06, Johannes L=C3=B6thberg wrote:
>>Git should fail to clone if trying to clone from an non-existing
>>ref namespace, since it's the same as a non-existing repository
>>
>>Signed-off-by: Johannes L=C3=B6thberg <johannes@kyriasis.com>
>>---
>>
>>Changes since v1:
>>
>>* Fixed the namespace check, since I apparently forgot to check with =
a
>>  bare repo in my last test. D'oh.
>>
>>Two other options for this would be to either add a
>>get_git_namespace_len() function and use that, or a is_namespaced()
>>functon. But since it's only used here for now at least it feels simp=
ler
>>to not bloat the codabase with another function which has no other us=
e.
>>
>
> I should note that I have a small test script written now, ready to b=
e
> converted into a git test, though I want some opinions on whether the
> patch would be merged before bothering to convert it.

You would probably want new tests, but more importantly did you make
sure this passes existing tests?  It seems to break 5509 (there
could be others) at least for me.
