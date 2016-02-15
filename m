From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http: add option to try authentication without username
Date: Mon, 15 Feb 2016 15:19:25 -0500
Message-ID: <CAPig+cTr1eW1KLsZGpY98hUhJ2EHdPopz9C_gTztZRdNPBQTmQ@mail.gmail.com>
References: <CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
	<1455561886-42028-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 21:19:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVPcJ-0001Xu-8T
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 21:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbcBOUT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 15:19:27 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34221 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbcBOUT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 15:19:26 -0500
Received: by mail-vk0-f52.google.com with SMTP id e185so116192106vkb.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 12:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ItAGC+44ywhf0g8YJexQU2Hxn4Ly7npLj2eE+WEKP6o=;
        b=DLjHHSHIUxgJe/cIb0zLC8UYSw0R1iNHENOOl/WwSfv4D/tDQqXPGFo8pr6KdwiS0j
         Lm1xnenfRb1XtoqVKydjtswIgeTd9ONFCqW47tAYvS2sxG3NEJQ2B7h26wgpBxf6UVln
         rztQamfqtu+mTCnvxxPr8PBudSOSMkf741FiuX8A0K9q66c+F/sswgvKuWfw9byTZYdb
         OgLDrvtsu8DamGK41KgKyOEJxauYTJ4J98BXkmLPJb2DypY9DZPVl3ELSG20XtgVLiae
         fOutbAOWd/XuFBuxNC4usmAt9tkMtugG93fZVhf9arqrechvVFPsiZ0Y4RwNzsmo/ubi
         RWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ItAGC+44ywhf0g8YJexQU2Hxn4Ly7npLj2eE+WEKP6o=;
        b=Nd9hd3C8diy54KMhexVQkYfoFh3F3ur7nInWTRQSMa+uzPQxkTXlQVg7vlkN0Aokn2
         3VBZIks56YQU0Ue7dmj/5GZTpywLn5SvxzAbeSp8B4nezQI4Tf1mqj0eyBlEosMBc3Em
         Rk8Mb+BpI8e3KdvffQ1E1mr5VP+ut0xqp7+1rlJm8W9ZF6Cs5x5tkndR1xfEjwm9hcB3
         gTIfqjwseho02X46LEs7klPunmblC8OBt0OgBWsF6+3uwNpo8HbWrJZk5QDSWlmrBUTz
         o0tLdJcpfth6wqgF6ruWjTxQ09znPVLmguSwiuz7Wxq72GsPYXPO7CL/uJ1c+7p6EwOD
         ovug==
X-Gm-Message-State: AG10YOTxhpumT6/ykmaw1C7JAnkpsp1bdWjU1GivuNPkFDgpB8Pz76nQ6FnUP+WleKWbQFz5MXhd6tAX2Ww+iQ==
X-Received: by 10.31.41.14 with SMTP id p14mr15137433vkp.151.1455567565481;
 Mon, 15 Feb 2016 12:19:25 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 12:19:25 -0800 (PST)
In-Reply-To: <1455561886-42028-1-git-send-email-sandals@crustytoothpaste.net>
X-Google-Sender-Auth: pmAIoRnQb-MMPOosqimX9ZpM9zk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286231>

On Mon, Feb 15, 2016 at 1:44 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Performing GSS-Negotiate authentication using Kerberos does not require
> specifying a username or password, since that information is already
> included in the ticket itself.  However, libcurl refuses to perform
> authentication if it has not been provided with a username and password.
> Add an option, http.emptyAuth, that provides libcurl with an empty
> username and password to make it attempt authentication anyway.

I'm not familiar with this code, so let me know if my comments (below)
are off the mark...

> ---
> diff --git a/http.c b/http.c
> +++ b/http.c
> @@ -299,14 +300,22 @@ static int http_options(const char *var, const char *value, void *cb)
>  static void init_curl_http_auth(CURL *result)
>  {
> -       if (!http_auth.username)
> +       if (!http_auth.username) {
> +               if (curl_empty_auth)
> +                       curl_easy_setopt(result, CURLOPT_USERPWD, ":");

Does this need to take LIBCURL_VERSION_NUM into account? Other code
which uses CURLOPT_USERPWD only does so for certain versions of
libcurl, otherwise CURLOPT_USERNAME and CURLOPT_PASSWORD is used.

>                 return;
> +       }
>
>         credential_fill(&http_auth);
>
> @@ -827,7 +836,7 @@ struct active_request_slot *get_active_slot(void)
>  #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
>         curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
>  #endif
> -       if (http_auth.password)
> +       if (http_auth.password || curl_empty_auth)
>                 init_curl_http_auth(slot->curl);
>
>         return slot;

Rather than sprinkling curl_empty_auth special cases here and there,
would it be possible to simply set http_auth.username and
http_auth.password to empty strings early on if they are not already
set and curl_empty_auth is true, and then let the:

    strbuf_addf(&up, "%s:%s",
        http_auth.username, http_auth.password);

in init_curl_http_auth() handle them in the normal fashion, with the
end result being the same ":" set explicitly by this patch?
