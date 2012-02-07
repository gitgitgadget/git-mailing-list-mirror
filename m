From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] commit: introduce a config key to allow as-is commit
 with i-t-a entries
Date: Mon, 6 Feb 2012 18:59:43 -0600
Message-ID: <20120207005943.GA2149@burratino>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-3-git-send-email-pclouds@gmail.com>
 <7vhaz37nce.fsf@alter.siamese.dyndns.org>
 <CACsJy8Be=WLv1Zz5CqQMYfi8dJN6M980kVuckAQKAujVo8xFkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 01:59:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuZPW-0007ta-FK
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 01:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174Ab2BGA7u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 19:59:50 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53870 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab2BGA7t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 19:59:49 -0500
Received: by iacb35 with SMTP id b35so9270993iac.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 16:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nzE5bZd/awFtuwfmjWXyyyOukCCpJsHHGqjDR4ucKqM=;
        b=EzzxIXXDyjl+QVitqkfsHNlRTN5yIiPpYRFbifgXv99ze2xGVJsXnv8UlESltJZzO5
         mYbWeILoZKYdMiUHEx4Ufke/pbRhIPzYwX56p0nuqQCSAdpcjqVtbAihLt7JwU9qthTt
         dhTmc9nNXMQfDDgVMzjtnb+KdB9g4351LPqQw=
Received: by 10.50.153.233 with SMTP id vj9mr5155112igb.16.1328576389054;
        Mon, 06 Feb 2012 16:59:49 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wn6sm18178040igb.3.2012.02.06.16.59.48
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Feb 2012 16:59:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8Be=WLv1Zz5CqQMYfi8dJN6M980kVuckAQKAujVo8xFkQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190127>

Nguyen Thai Ngoc Duy wrote:
> 2012/2/7 Junio C Hamano <gitster@pobox.com>:

>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (i < active_nr)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warning(_("You are committing as-is wit=
h intent-to-add entries as the result of\n"
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "\"g=
it add -N\". Git currently forbids this case.
>>
>> Can we phrase this a bit better?
>>
>> It is not like "forbids", but is "giving up because you didn't tell =
me
>> what content to include in the commit, even though you said you will=
 tell
>> me later".
>
> "rejects"? I would rather say "see `git add -N` man page for more
> explanation" than putting it here. The warning is quite long as it is
> right now.

If I ruled the world, it would say something like this:

	error: you intended to add "foo.c" but did not add it; not committing
	hint: to commit all changes to tracked files, use "commit -a"
	hint: to commit without adding "foo.c", use "commit --ignore-intent-to=
-add", which may become the default in future versions of git

But without the long line. ;-)
