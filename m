From: John Koleszar <jkoleszar@google.com>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Fri, 5 Apr 2013 17:54:55 -0700
Message-ID: <CAAvHm8NV4OD+QqVp-7oOzsSdAwten6gTpfUFfi85jv_VQ3soFA@mail.gmail.com>
References: <CAAvHm8PCQx18Gk2S7dicG+_GksjFqVLfPNCbism1sHnPUMDNzg@mail.gmail.com>
	<1365091293-23758-1-git-send-email-jkoleszar@google.com>
	<7v6202jjhx.fsf@alter.siamese.dyndns.org>
	<CAAvHm8NyJ3nRZPygy+grMw5BLhLe8eWfEBNfK1tkC8Y34jRynA@mail.gmail.com>
	<20130405023516.GA32290@leaf>
	<20130405025655.GA25970@sigill.intra.peff.net>
	<7vobdtee12.fsf@alter.siamese.dyndns.org>
	<20130405054328.GA12705@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:51:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWRe-0001b9-T6
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521Ab3DFAy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 20:54:58 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:39918 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932514Ab3DFAy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 20:54:57 -0400
Received: by mail-wg0-f43.google.com with SMTP id f12so4384168wgh.22
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 17:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=VmegMZz/k+zfqEbC03iuSI1OEE/Xpw4zDlmNTXIfdbQ=;
        b=kzwoDUFhdrIrdkfWMobog6hrl5En5QMBx1XTf/3XCOCwiWkjuosE73BzX1yCfreIxo
         3wnOtnvtXFva9/40sQ8DtpirZnrGWS6P+vut8FAnsDhcmOR9sVhOt0/4XOvdhRItqmvV
         mEj6dDfLI/Ba1Fe/cZd4PdTyg4Vr0wzN9xQXKniP2vj6WCK7yxkNL6+5qWUtQvYIUtui
         f2ImFfH425BYfRzcSyIiACZxGLMFqPnnsOHzd405a3wbrXkVea35iXNTxcoe2IfjD5ik
         mXQsmSRJwoCWRcxZJKYbFsflgukhDAvue/e4luwDu5qm8neCbfBGS3v+afaYxtYyMmz/
         hRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=VmegMZz/k+zfqEbC03iuSI1OEE/Xpw4zDlmNTXIfdbQ=;
        b=b7YJntSjQuYaCGa8jGXvGJVX+Gu7f6tMmtbk/wYUc2XmOmkoyQ1zaMGLutdt6ku3Wu
         eKrSEHKEJazxr4YX9XAnHVa1a+7sjv8038uE2My+8XE/m1VaZsQcGO19VAbe7du6QmsN
         JirYr44kIEtiM7fzYllcqnse/K1+ROWXPpvW3QOtb4IATAu/VOSDZfdXFlQy4JMeQ3PK
         Tv4KAajIDxJ30MqOy/NxkXYNLt0Izhp4th2j+sC0gzSHz7WvwzwAccrT56HSJNtHL0Ao
         cJHy8WwZ/FdDDttaudAyelTUVBq4jbZ8q3Vf1TdCzXUF1n2JvOadkx/297hS/UpnAZby
         S3BQ==
X-Received: by 10.194.171.74 with SMTP id as10mr19891561wjc.0.1365209695892;
 Fri, 05 Apr 2013 17:54:55 -0700 (PDT)
Received: by 10.194.62.165 with HTTP; Fri, 5 Apr 2013 17:54:55 -0700 (PDT)
In-Reply-To: <20130405054328.GA12705@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQk+ovIoZQq20V+PvO75Pj+1+r257cY2cy16u+L+sO61WyTEUIx2ev9KNBz2ynXrAIoWvfb56J5ifI7dsoZvDvNI+Vq+TVStg8LTwru69w126r7HCY3X9HOXhfra5+EyINFerTVAUWfds/LDRNwVAO9S0a0PDvgmZOAP6YpaugI2ELkNb2ISxKvB9l8EcgBRueTeDBzb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220237>

On Thu, Apr 4, 2013 at 10:43 PM, Jeff King <peff@peff.net> wrote:
>
> On Thu, Apr 04, 2013 at 10:34:49PM -0700, Junio C Hamano wrote:
>
> > > +static void get_head(char *arg)
> > > +{
> > > +   struct strbuf buf = STRBUF_INIT;
> > > +   head_ref_namespaced(show_text_ref, &buf);
> > > +   send_strbuf("text/plain", &buf);
> > > +   strbuf_release(&buf);
> > > +}
> >
> > You identified the right place to patch, but I think we need a bit
> > more than this.
> >
> > The show_text_ref() function gives "SHA-1 <TAB> refname". It is
> > likely that the dumb client will ignore the trailing part of that
> > output, but let's avoid a hack that we would not want see other
> > implementations imitate.
>
> Oh, right. I was thinking too much about normal clients which see HEAD
> in the ref advertisement; of course the dumb client is expecting to see
> the actual HEAD file.
>
> > One advantage dumb clients has over smart ones is that they can read
> > HEAD that is a textual symref from a dumb server and learn which
> > branch is the default one (remote.c::guess_remote_head()) without
> > guessing.  I think this function should:
> >
> >  - Turn "HEAD" into a namespaced equivalent;
> >
> >  - Run resolve_ref() on the result of the above;
> >
> >  - Is it a symbolic ref?
> >
> >    . If it is, then format "ref: <target>\n" into a strbuf and send
> >      it (make sure <target> is without the namespace prefix);
> >
> >    . Otherwise, HEAD is detached. Prepare "%s\n" % sha1_to_hex(sha1),
> >      and send it.
>
> Yes, that sounds right; it is basically just reconstructing a HEAD
> file. What do the HEADs inside namespaces look like? Do they refer to
> full global refs, or do they refer to refs within the namespace?
>
> If the latter, we could just send the HEAD file directly. But I suspect
> it is the former, so that they can function when non-namespaced commands
> are used.
>

Here's a quick cut at this. Seems to work ok in local testing, I
haven't updated the test suite yet. If the namespaced HEAD is a
symbolic ref, its target must have the namespace prefix applied, or
the resolved ref will be from outside the namespace (eg
refs/heads/master vs refs/namespace/ns/refs/heads/master). This seems
to be handled at write time, not sure if we need to do more
verification here or not.

diff --git a/http-backend.c b/http-backend.c
index d32128f..da4482c 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -404,13 +404,40 @@ static void get_info_refs(char *arg)

        } else {
                select_getanyfile();
-               head_ref_namespaced(show_text_ref, &buf);
                for_each_namespaced_ref(show_text_ref, &buf);
                send_strbuf("text/plain", &buf);
        }
        strbuf_release(&buf);
 }

+static int show_head_ref(const char *name, const unsigned char *sha1,
+       int flag, void *cb_data)
+{
+       struct strbuf *buf = cb_data;
+
+       if (flag & REF_ISSYMREF) {
+               unsigned char sha1[20];
+               const char *target = resolve_ref_unsafe(name, sha1, 1, NULL);
+               const char *target_nons = strip_namespace(target);
+
+               strbuf_addf(buf, "ref: %s\n", target_nons);
+       } else {
+               strbuf_addf(buf, "%s\n", sha1_to_hex(sha1));
+       }
+
+       return 0;
+}
+
+static void get_head(char *arg)
+{
+       struct strbuf buf = STRBUF_INIT;
+
+       select_getanyfile();
+       head_ref_namespaced(show_head_ref, &buf);
+       send_strbuf("text/plain", &buf);
+       strbuf_release(&buf);
+}
+
 static void get_info_packs(char *arg)
 {
        size_t objdirlen = strlen(get_object_directory());
