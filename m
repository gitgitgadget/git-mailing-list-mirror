From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH 1/2] Unification of user message strings
Date: Mon, 19 Mar 2012 21:16:25 +0100
Message-ID: <4F679419.8020204@lyx.org>
References: <1332179503-2992-1-git-send-email-vfr@lyx.org> <1332179503-2992-2-git-send-email-vfr@lyx.org> <7v1uoobcsv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:16:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9j0M-0001XE-7p
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 21:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759391Ab2CSUQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 16:16:29 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47727 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759168Ab2CSUQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 16:16:28 -0400
Received: by eekc41 with SMTP id c41so2850052eek.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 13:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=v1YqbYdrcVAfKMaJ3EW81j77aBrPT1qHxj68F92CNz4=;
        b=V2YJkcGQQ6zLINnKtyRd28OBiLwVCSnkReUaa+MtufjOhPhhUjFImgsbou2PCBqIYQ
         KtLHbX1NPxWn3V5x7TlanmttG7AFYAnaMs2zuwDVQF6QHEu5QuAuUM+gPF734KLBXpWu
         jvZyIDR2NX6179pngXFy+6k1exSzUUgO4g3FtUQVpJ0vaXBrhnvhai2E6ZWf/97GARp4
         krQmHZkQkjZsr9qSpqMQtuXZLbnvSpY/7vrHHCeVcYZ6Ktu9BLLlweEdAMZx/Gofte46
         rfPS/fch9j8HQ8Cnr29H5qKFT3B1/kejHAAjdMBJGzSi2iY2yj/2ggmR49QOf6NFedgg
         jmBw==
Received: by 10.213.20.12 with SMTP id d12mr834802ebb.278.1332188186979;
        Mon, 19 Mar 2012 13:16:26 -0700 (PDT)
Received: from [192.168.1.5] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id y11sm53045125eem.3.2012.03.19.13.16.26
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Mar 2012 13:16:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7v1uoobcsv.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQlmbn2KtDGwcpkRSsQR2eLVNUTN2bzQmn8zfXVhStki4NB4prS5IJPNB4AZM3PN66Fk9NJr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193455>


>> From: Vincent van Ravesteijn<vfr@lyx.org>
>>
>> Rewrite user messages to stick to a uniform style for all messages. From the surrounding code, the following guidelines were deduced:
>> - messages start with a capital,
>> - short messages do not end with a full stop,
>> - paths, filenames, and commands are quoted by single quotes (if not separated by the normal text by a ':'),
>> - 'could not' is used rather than 'cannot'.
>>
>>
>> @@ -56,7 +56,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
>>   	args[3] = NULL;
>>
>>   	if (start_command(&gpg))
>> -		return error(_("could not run gpg."));
>> +		return error(_("Could not run 'gpg'"));
> Ok with s/c/C/, but I am not sure about the 'gpg' bit.  The name of the
> program and path to it can be configured so the user may be expecting to
> run a program called gnupg, and unquoted gpg feels more like a generic
> term to refer to the program.  It might be worth using all-CAPS, though.

Yes, all-CAPS seems the better alternative.

>> -		return error(_("cannot open %s: %s"), filename,
>> +		return error(_("Could not open '%s': %s"), filename,
> Honestly speaking, I would personally prefer "Cannot open" over "Could not
> open".  Yes, all the error messages report _after_ we attempted to do
> something and finding that we _couldn't_ do that thing, so "Could not" may
> be technically more correct, but still...
>
> But that is probably just me.
>

No it's not you, grep tells me "Cannot" is indeed the most occuring, 
except in sequencer.c (which I stumbled on first).


> Other than that, the patch looks good; let's hear from others, too.

Ok, let's hear other comments, and then I will send a reroll to fix up 
the things above.

Vincent
