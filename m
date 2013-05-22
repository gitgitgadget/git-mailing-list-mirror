From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Reading commit objects
Date: Wed, 22 May 2013 12:59:07 -0700
Message-ID: <CAJo=hJt7W4O3L6M6TmEvEfCKvjqwdXHAbSjCwazuzNsPzeKvhA@mail.gmail.com>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
 <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com>
 <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com>
 <CAJo=hJtqACW+CR5FkmDfwyK1Wg3Kcppy6DbW7P=On_qJyvsYvQ@mail.gmail.com> <CABx5MBSmCN=avRDCJ+RU8FoRDaGG=6uRfTdVR9m3A=SqpuKAjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Szakmeister <john@szakmeister.net>, git <git@vger.kernel.org>
To: Chico Sokol <chico.sokol@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 21:59:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfFCC-0008Cm-3b
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 21:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757092Ab3EVT7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 15:59:31 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:40378 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757126Ab3EVT72 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 15:59:28 -0400
Received: by mail-ie0-f178.google.com with SMTP id tp5so2013492ieb.9
        for <git@vger.kernel.org>; Wed, 22 May 2013 12:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ELMUu5MVaGMn7bKap8x0LelGcmga1Dbgw6ScQebfUEg=;
        b=HuUsKmc7ZhYpB4LQjGeunrlsT3227sCeYy9SzMeWKrAH7k4nxv4T2FOtQlmTUhXiZU
         xw0WCGPBadMTrZVud6ElYNq3sbMfWs4CmEMIZdP/HiIYsnNXMPaqjKaF6lm7Xmh53MCg
         FAWIQzen5yUH1XFKdaMg1uDaC9OqlMMvXwxYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=ELMUu5MVaGMn7bKap8x0LelGcmga1Dbgw6ScQebfUEg=;
        b=FH9KP/K+fopYdIEnq3/J+rvudr9/LoRyi0AB0J+vLIiGaejUUEr2w62aaCisaeuZaN
         05q4s9Up4h8wLb+lS1xru2xJy/pBzYWRJrlhL6dWWHtS58GeCksaf3jOkM8lMThKRT0i
         fKV1nqwSdJAfIBCjUEgl5bqMJy8/23+pYVDjR7jpj6+t38NlQaYOM+mfZJ5ewTIx25Or
         QNMvUKL0lKlSegsXdB9hZMD2FPdOIbGQM0i3W6/SRGG7AMlPdvCs+Z7L4fb8BnvwkZfF
         6hWRE8VrLaS5yggA8sdZ+3eIw1pNPq2Ue1iJ+4eWEryjvlsLzn/XZUc3FUTnnoD7EvB7
         gOyg==
X-Received: by 10.50.50.195 with SMTP id e3mr3307234igo.109.1369252767580;
 Wed, 22 May 2013 12:59:27 -0700 (PDT)
Received: by 10.64.82.38 with HTTP; Wed, 22 May 2013 12:59:07 -0700 (PDT)
In-Reply-To: <CABx5MBSmCN=avRDCJ+RU8FoRDaGG=6uRfTdVR9m3A=SqpuKAjQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQn9mRVO9KpCD7/SUGxURtmHJUe5XFZHW6dyANAewOczk5STBK7Z2qSMuh8MzEvMA744vqoO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225187>

On Wed, May 22, 2013 at 7:25 AM, Chico Sokol <chico.sokol@gmail.com> wrote:
>> Your code is broken. IOUtils is probably corrupting what you get back.
>> After inflating the stream you should see the object type ("commit"),
>> space, its length in bytes as a base 10 string, and then a NUL ('\0').
>> Following that is the tree line, and parent(s) if any. I wonder if
>> IOUtils discarded the remainder of the line after the NUL and did not
>> consider the tree line.
>
...
> Is the contents of a unpacked object utf-8
> encoded?

Its more complicated than that. Commit objects are usually in utf-8,
unless a repository configuration setting told you otherwise, or an
encoding header appears in the commit. And sometimes that data lies
anyway. ISO-8859-1 is one of the safer forms of reading a commit, but
that also isn't always accurate.
