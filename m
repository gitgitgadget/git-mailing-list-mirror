From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 21/31] mailinfo: move [ps]_hdr_data to struct mailinfo
Date: Wed, 14 Oct 2015 15:57:34 -0700
Message-ID: <xmqq37xdhxcx.fsf@gitster.mtv.corp.google.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
	<1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1444855557-2127-22-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 00:57:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmUzM-00075O-MJ
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 00:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbbJNW5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 18:57:36 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35874 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbbJNW5f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 18:57:35 -0400
Received: by pabws5 with SMTP id ws5so2871709pab.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 15:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/mdneJQoQPe3YNq7hDmYgD3n3DzsKK7tlZ0BoxlSbHg=;
        b=Tvh7p6StmR+E+3uw0Kp+IVHDFlE80rtlPrgmWJCnvnViAmvBspAT1RtDM3h7Frgw/t
         k1N95v0wcUsIDVJDFITq1LAPzpB8ysJCY//yiJSHXCnl5jIEbDX7ZeIE6XWbmo9hdJFi
         g5PL55UjM1st/X3mnA+v5QC9b1+HmFxFhkP0hYXlp9r9WHRfWCkuR8P8UP5ZEh5zdEN/
         6gOmTKKBNj1clekqDaEEGBXRXfXOvKKBSLfA/jDUmX/Y54w+gHQBItwaZEJO7GA3MIPo
         mJijbkX0fozsH40YksujZkrfmsFMMeoXCdS4NtwrH78Nz6WHbWtBLQk9JVqVZhtNQAwS
         6/TA==
X-Received: by 10.68.143.4 with SMTP id sa4mr6164138pbb.111.1444863455341;
        Wed, 14 Oct 2015 15:57:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id kv9sm11633711pab.39.2015.10.14.15.57.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 15:57:34 -0700 (PDT)
In-Reply-To: <1444855557-2127-22-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Wed, 14 Oct 2015 13:45:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279638>

Junio C Hamano <gitster@pobox.com> writes:

> @@ -995,10 +995,10 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
>  
>  	/* process the email header */
>  	while (read_one_header_line(&line, mi->input))
> -		check_header(mi, &line, p_hdr_data, 1);
> +		check_header(mi, &line, mi->p_hdr_data, 1);
>  
>  	handle_body(mi, &line);
> -	fclose(patchfile);
> +	fclose(mi->patchfile);

... this is the bit that should have be in 20/31.
