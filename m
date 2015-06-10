From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 3/9] for-each-ref: add '--points-at' option
Date: Wed, 10 Jun 2015 12:25:19 +0530
Message-ID: <5577DF57.2020607@gmail.com>
References: <5573520A.90603@gmail.com> <1433621052-5588-1-git-send-email-karthik.188@gmail.com> <1433621052-5588-3-git-send-email-karthik.188@gmail.com> <xmqqzj4a9fpn.fsf@gitster.dls.corp.google.com> <5576D591.6030704@gmail.com> <xmqqvbew66q9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	matthieu.moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 08:55:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2ZvJ-0004ck-H6
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 08:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbbFJGz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 02:55:29 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34578 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778AbbFJGz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 02:55:26 -0400
Received: by pdbki1 with SMTP id ki1so31278048pdb.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=bSNGkN8+PYjdnOQCtPVjrOsTTbCixdx2wopodAIyhV4=;
        b=v18S9JTuUon4B4QclOs+jwuTidh9mCZEyj7z+8Fl76P3Gr8s9umBKQZoFkpzV9oJlw
         sMdUi4f0ipIQUAoADzTlmauGTTE7Cc4E4iK1mZMAt0JC8CkdeNZ97kD6j+ITF1/eJ6Zi
         HZ1mDwFC61ygkLM177RBYisPyQ+2Wx1UBSsSxwaR/xxT9ugoMbBIjVba4QbYEDql1iL+
         Q4oEYHav21RTd6I4yW5CGBjkKVO1/eC2pmMU7IWR4UDCmxKyvBOjB8RHKoYIEbIVqdzo
         tmqUg0mgoJqjJjWUNoxXjRVNxhLyNEpkm8A+yTMZBJTwxYoiWnSHx+BYKVd9piMLfauY
         0fEg==
X-Received: by 10.66.222.72 with SMTP id qk8mr3077333pac.7.1433919325781;
        Tue, 09 Jun 2015 23:55:25 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id d5sm7503574pdl.85.2015.06.09.23.55.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 23:55:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqvbew66q9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271256>

On 06/10/2015 12:37 AM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> >>> @@ -54,7 +59,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
> >>>        /* for warn_ambiguous_refs */
> >>>        git_config(git_default_config, NULL);
> >>>
> >>> -    memset(&ref_cbdata, 0, sizeof(ref_cbdata));
> >>
> >> I cannot quite see how this change relates to the addition of the
> >> new option.
> >>
> >
> > Well if we memset() after calling parse_opt_points_at(), we loose all
> > the information we would have obtained.
> > So the memset() is moved to an earlier location.
>
> which I did not see, because I expected the code to follow the usual
> "no decl-after-statement" pattern.  IOW
>
> >>        int maxcount = 0, quote_style = 0;
> >>        struct ref_filter_cbdata ref_cbdata;
> >> +    memset(&ref_cbdata, 0, sizeof(ref_cbdata));
> >>
> >>        struct option opts[] = {
> >>            OPT_BIT('s', "shell", &quote_style,
>
> Don't do that.  Always start your function like so:
>
>     type funcname(args)
>          {
>              declarations;
>
>                  first statement;
>         ...
>
> with no blank line within declarations block and a blank line after
> the declarations block.
>
Will do, thanks!

-- 
Regards,
Karthik
