From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git fails: segfault at 0 ip 00000000004076d5 sp 00007fff7806ebc0
Date: Fri, 12 Oct 2012 18:29:37 +0200
Message-ID: <CABPQNSYyh-gk8aD9SKLzo0MDBkGECthdGZiT1mB1pA0ajdB8Cw@mail.gmail.com>
References: <CAJa+X0OkzAX9E2SnDmU=on0yzzVZ9OMa2dJZgKMK=gQu2Rhf_Q@mail.gmail.com>
 <CAJa+X0MefHXTu_D7-SN8itQVO4sMyc4O7=bK=-sUP+W4GHOu9g@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Brad Hein <linuxbrad@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 18:30:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMi8B-0003wA-Ue
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 18:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759747Ab2JLQaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 12:30:21 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:47823 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759209Ab2JLQaT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 12:30:19 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so3193184vbb.19
        for <git@vger.kernel.org>; Fri, 12 Oct 2012 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Zr8ttUolb7bWgVzTagIC7LPM94dVTSVZ5BwtYzE1NWs=;
        b=xzp8/DBxXi2ruu1Msl3UJTXA72BWO6fSqoKZ3ZE2yxlfkRtN0UHUE4d0a2YKiQlkGj
         LFz6WA9SVTNk4Qhpg4xfeIJLiwTZTdOhco1Wzw6O8YHQWR5yUW2JtQ0HsZ/RRIryiE2I
         y/QEXwOdeIJQAipKJ5zpqiHqOIISEaEaDRwXcVDxBE0UhjDc+XsexO/Tt0fgmGqI4AuR
         hXr1W5h0Uu8gGsiulO+9s26LTmHH/YnPnMAN/UmrvOeMvc1xRmYWBUbYxw2fVFumneRI
         iueq49FbRxcKhfv9lmruDiAmEXMb14fI/IbsCd+LMyxYpY5f/n752LYQeO0w8hB5QE2s
         GaXg==
Received: by 10.58.94.109 with SMTP id db13mr2921265veb.39.1350059418401; Fri,
 12 Oct 2012 09:30:18 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Fri, 12 Oct 2012 09:29:37 -0700 (PDT)
In-Reply-To: <CAJa+X0MefHXTu_D7-SN8itQVO4sMyc4O7=bK=-sUP+W4GHOu9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207552>

On Fri, Oct 12, 2012 at 6:58 AM, Brad Hein <linuxbrad@gmail.com> wrote:
> In Fedora 17
> With git-1.7.11.7-1.fc17.x86_64 (rpm)
>
> I try to clone a particular repository but git just returns, having
> not cloned the repo. Seems like a bug. Details follow:
>   $ git clone http://gnuradio.org/git/gnuradio.git
>
> While the command fails a message is logged to syslog. Repeated
> attempts to clone the repo yield the same result:
>   Oct 11 21:38:25 localhost kernel: [662703.442645]
> git-remote-http[25796]: segfault at 0 ip 00000000004076d5 sp
> 00007fff7806ebc0 error 4 in git-remote-http[400000+96000]
>   Oct 11 21:39:00 localhost kernel: [662737.899829]
> git-remote-http[25837]: segfault at 0 ip 00000000004076d5 sp
> 00007fff37c5ef20 error 4 in git-remote-http[400000+96000]
>   Oct 11 21:39:25 localhost kernel: [662763.341248]
> git-remote-http[25873]: segfault at 0 ip 00000000004076d5 sp
> 00007fff6310d470 error 4 in git-remote-http[400000+96000]
>
> A tcpdump reveals that the last thing the client does is requests a
> file that doesn't exist on the server (404). Details are in my post on
> FedoraForums: http://forums.fedoraforum.org/showthread.php?p=1607891&posted=1#post1607891
>
> Problem mitigated by downgrade to "git-1.7.10.1-1.fc17.x86_64" or
> "git-1.7.11.4-3.fc17.x86_64" or try to clone a different repository.

Thanks for reporting. I gave it a quick go, and the issue seems to
also be present in the current 'master'.

The problem is a NULL-pointer dereferencing introduced in 8809703
("http: factor out http error code handling"), where the code assume
that slot->results still points to http_request::results. This
assumption seems to be wrong.

This seems to step around the issue, but I don't know if
http_request::results should be set to NULL in the first place. Jeff?

diff --git a/http.c b/http.c
index 345c171..ac3ab16 100644
--- a/http.c
+++ b/http.c
@@ -745,10 +745,8 @@ char *get_remote_object_url(const char *url,
const char *hex,
 	return strbuf_detach(&buf, NULL);
 }

-int handle_curl_result(struct active_request_slot *slot)
+int handle_curl_result(struct active_request_slot *slot, struct
slot_results *results)
 {
-	struct slot_results *results = slot->results;
-
 	if (results->curl_result == CURLE_OK) {
 		credential_approve(&http_auth);
 		return HTTP_OK;
@@ -822,7 +820,7 @@ static int http_request(const char *url, void
*result, int target, int options)

 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
-		ret = handle_curl_result(slot);
+		ret = handle_curl_result(slot, &results);
 	} else {
 		error("Unable to start HTTP request for %s", url);
 		ret = HTTP_START_FAILED;
diff --git a/http.h b/http.h
index 12de255..12c27fa 100644
--- a/http.h
+++ b/http.h
@@ -78,7 +78,7 @@ extern int start_active_slot(struct
active_request_slot *slot);
 extern void run_active_slot(struct active_request_slot *slot);
 extern void finish_active_slot(struct active_request_slot *slot);
 extern void finish_all_active_slots(void);
-extern int handle_curl_result(struct active_request_slot *slot);
+extern int handle_curl_result(struct active_request_slot *slot,
struct slot_results *results);

 #ifdef USE_CURL_MULTI
 extern void fill_active_slots(void);
diff --git a/remote-curl.c b/remote-curl.c
index 10fa8f1..42716c5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -356,7 +356,7 @@ static int run_slot(struct active_request_slot *slot)
 	slot->curl_result = curl_easy_perform(slot->curl);
 	finish_active_slot(slot);

-	err = handle_curl_result(slot);
+	err = handle_curl_result(slot, &results);
 	if (err != HTTP_OK && err != HTTP_REAUTH) {
 		error("RPC failed; result=%d, HTTP code = %ld",
 		      results.curl_result, results.http_code);
