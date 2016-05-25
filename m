From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/3] Submodules: have a depth field in the .gitmodules file
Date: Wed, 25 May 2016 15:44:58 -0700
Message-ID: <CAGZ79kZOmqcB_q48upzpEnF6Lb9wqt2NMOBhTH7EvE5LfAqabg@mail.gmail.com>
References: <20160525220006.27138-1-sbeller@google.com> <xmqqeg8pzrsu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 00:45:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5hY3-0001k2-1Z
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbcEYWpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:45:01 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33413 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbcEYWpA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:45:00 -0400
Received: by mail-ob0-f169.google.com with SMTP id v12so985780obg.0
        for <git@vger.kernel.org>; Wed, 25 May 2016 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x04cosNP54k6EdyAcd3UlKqbS8PLdTaFiinDSOj+yvo=;
        b=n5Kx4e/TPPUZvZdUt5vL+yt5cnWKPpy8LDteGwZlHr3nONcS/JSV/ewtHHvx0n17uD
         8eqffmhNci/vzuGT/2WoVgxpjeynjaWaoXoXFIrgbP7b38LSPOiR1gWeFTKGG+h8ioyJ
         1MMGSKBKZa8F16mz05h9G7BtNaa2fHhYmcYDEyMPfXjrU7gh9ZZvHSzpYv0T8mBKBLZ9
         k4kIepThmaeDPOpbnGLGdwBFM1YaPe9ZOqbNJolff8dgyABPC++MWoKtbgR2W/pPnYvS
         mZ5WOordr2ljP3ExfnBeohi6AcA8c17b6muExCeOSj/TjgdBCtr8l1FfbnsDLfyU4z8P
         gB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x04cosNP54k6EdyAcd3UlKqbS8PLdTaFiinDSOj+yvo=;
        b=cJUgHaY9qWwHmgy+B+PsBQnG7tplwaF+73fJX96fSuGzBuI3Vm8ZTxVYe38I4IaJWU
         AM/EVlBHyxUF89Id+CLAn4YypNpnFAH6Ahz+ckVBJPtCwl0LZQhSWSO0lGeZaDVXMf9s
         ScLM2Tt1JbiRMTnk/cE4EDDRWYjWv+73IbvjGJpAS58hPICa3+OdkSbA+YSfNQOKjs66
         pL/sV1lGnkIFjG2uGKoCN4IQsQynATwIBEMkAmnt2ZSRl9ntBCKByeZX1sYF8J5Bb1fD
         ao9FPnKNYvx+aLNa+XJe4oi3OWjgV5hmj1iv7R7W4K1G+6IoM3Q/qQoZXmibU5yRSh7+
         37xQ==
X-Gm-Message-State: ALyK8tL6E0TackD45SzKq7g4bFV0BBJbA/EKtmGNkfgVTsv3NzXSmSDPA9vhS7CZ/P7n0CSBUwDQu4/njnoHyWgt
X-Received: by 10.50.38.130 with SMTP id g2mr241869igk.93.1464216298923; Wed,
 25 May 2016 15:44:58 -0700 (PDT)
Received: by 10.107.136.19 with HTTP; Wed, 25 May 2016 15:44:58 -0700 (PDT)
In-Reply-To: <xmqqeg8pzrsu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295605>

On Wed, May 25, 2016 at 3:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Sometimes the history of a submodule is not considered important by
>> the projects upstream. To make it easier for downstream users, allow
>> a field 'submodule.<name>.depth' in .gitmodules, which can be used
>> to indicate the recommended depth.
>
> Hmph.  I can understand and certainly agree with the first sentence,
> but I am not sure if "depth", if it is anything other than "1" or
> "infinity", is a reasonable value.
>
> I'd understand if a project wants to say something like "at this
> moment, history before v2.0 tag does not matter", though.

I fell for the trap, like all depth related problems fall into.
I came up with the easiest solution to be implemented into Git,
not what the user actually wants.

Background for this change is trying to get a similar thing like the
"clone-depth"
field from repo manifests implemented into Git.
And looking at e.g. [1], this is either non existent (infinity) or 1.
So maybe instead of giving a depth recommendation in the .gitmodules,
we only fill in a boolean config "[non]shallow" which defaults to non shallow
in case of not giving the field.

Thanks,
Stefan



[1] https://android.googlesource.com/platform/manifest/+/master/default.xml
