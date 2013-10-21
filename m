From: pro-logic <pro-logic@optusnet.com.au>
Subject: Re: Windows performance / threading file access
Date: Mon, 21 Oct 2013 15:58:45 -0700 (PDT)
Message-ID: <49cde110-f3e5-43d9-b399-6b5a6ce59014@googlegroups.com>
References: <CAHOQ7J_ZZ=7j-5ULd7Tdvbiqg4inhwi+fue_w6WAtNRkvZSwsg@mail.gmail.com> <52570BC1.2040208@gmail.com> <52574B90.3070309@gmail.com> <CAHOQ7J_sNnajm9M+QUd-QwkQGP2vOidzAW5_5EzsdwBGTDCnSA@mail.gmail.com> <3bb056f6-5f8b-486e-8e5e-9bf541bd0d0b@googlegroups.com>
 <52601562.2090301@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3360_17828361.1382396325175"
Cc: pro-logic <pro-logic@optusnet.com.au>, 
	Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org, 
	szager@google.com
To: msysgit@googlegroups.com
X-From: msysgit+bncBCNJBMNCRQBBBJXDS2JQKGQEENKNOLY@googlegroups.com Tue Oct 22 00:58:52 2013
Return-path: <msysgit+bncBCNJBMNCRQBBBJXDS2JQKGQEENKNOLY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f59.google.com ([209.85.213.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCNJBMNCRQBBBJXDS2JQKGQEENKNOLY@googlegroups.com>)
	id 1VYOQx-0000ld-Mw
	for gcvm-msysgit@m.gmane.org; Tue, 22 Oct 2013 00:58:47 +0200
Received: by mail-yh0-f59.google.com with SMTP id l109sf1487616yhq.24
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Oct 2013 15:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=bCsbNVADbGN3Hu0EqjFoeHvcc5CKoyFU6iBqbL+gsMU=;
        b=m2jbYHUSL+Na0XjRXikXwiNGj+p5ZsEeERKhZyc57OJQeMXVJarzdl9TiIjNfZ9z9N
         JcIm0WxHR2+Wf6HfLxTMxyezX2jm+Y71O1uGN1l/AKa9xrBk8i7XnRQqi9TLABVJLWTz
         HL1Mlubj+shnEW6Sr7c59qI0ZjIRoS4s2++BHUZ2oeus8crtJkaWrTubQziBUuH9u0BG
         iLw5iJhQ1i8xg5c1qx5JtHHKy+dFH3vs1FiOvuIsK1oBje5azfJE1BkzJFkXIo1rnV0Z
         AlsMOYmoIBKeDuYFZI7s4h1Mf0Bwg42PZU+e1ZFItiMt+HE5WkLab3LiLY2MCdIPquNO
         15Gw==
X-Received: by 10.50.138.197 with SMTP id qs5mr314840igb.7.1382396326885;
        Mon, 21 Oct 2013 15:58:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.12.67 with SMTP id w3ls2014396igb.25.canary; Mon, 21 Oct
 2013 15:58:46 -0700 (PDT)
X-Received: by 10.50.138.197 with SMTP id qs5mr314838igb.7.1382396326085;
        Mon, 21 Oct 2013 15:58:46 -0700 (PDT)
In-Reply-To: <52601562.2090301@gmail.com>
X-Original-Sender: pro-logic@optusnet.com.au
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236449>

------=_Part_3360_17828361.1382396325175
Content-Type: text/plain; charset=ISO-8859-1

> The trace_performance functions require manual instrumentation of the 
code sections you want to measure
Ahh a case of RTFM :)

> Could you post details about your test setup? Are you still using WebKit 
for your tests?
I'm on Win7 x64, Core i5 M560, WD 7200 Laptop HDD, NTSF, no virus scanner, 
truecrypt, no defragger. 

I've tried to be a bit smarter with the intent of my code, and this is what 
I came up with.

diff --git a/cache.h b/cache.h
index 4bf19e3..2e9fb1f 100644
--- a/cache.h
+++ b/cache.h
@@ -294,7 +294,7 @@ extern void free_name_hash(struct index_state *istate);
 #define active_cache_changed (the_index.cache_changed)
 #define active_cache_tree (the_index.cache_tree)
 
-#define read_cache() read_index(&the_index)
+#define read_cache() read_index_preload(&the_index, NULL)
 #define read_cache_from(path) read_index_from(&the_index, (path))
 #define read_cache_preload(pathspec) read_index_preload(&the_index, 
(pathspec))
 #define is_cache_unborn() is_index_unborn(&the_index)
diff --git a/read-cache.c b/read-cache.c
index c3d5e35..5fb2788 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1866,7 +1866,7 @@ int read_index_unmerged(struct index_state *istate)
  int i;
  int unmerged = 0;
 
- read_index(istate);
+ read_index_preload(istate, NULL);
  for (i = 0; i < istate->cache_nr; i++) {
  struct cache_entry *ce = istate->cache[i];
  struct cache_entry *new_ce;
-- 

Interestingly when I run on a cleanly checked out blink repo my changes 
seem to make matters worse in terms of performance, but when working on a 
repo with ignored files in it it seems to work better. So for point of 
comparison I decided to run it on a comparison on a repo with working 
ignored files in it in this case msysgit/git after a 'make install'. When I 
get a few hours I'll try to build blink and re-run the numbers on a much 
much larger repo. 

This comparison is a average of 3 cold cache runs of the kb/fscache-v4 [a] 
vs kb/fscache-v4 with my above changes applied [b], with preloadindex and 
fscache set to true. 

For comparison
git status -s
[a] 3.02s
[b] 2.92s

git reset --hard head
[a] 3.67s
[b] 3.09s

git add -u
[a] 2.89s
[b] 2.08s


I noticed something interesting. Preload index uses 20 threads to do the 
work. When I was keeping an eye on them in task manager some threads will 
finish quite quickly, while others will run a lot longer. The way I 
understand the code at the moment the threads get equal chunks of work to 
perform. It's quite lilkely that even more performance could be obtained 
out of preload if the work splitting was 'smarter'. My currently best idea 
would be to use something like a lock-free queue to queue up the work and 
let the threads get the work of the queue. That way all threads are busy 
with work for longer. A candidate for the implementation would be libfds 
[1] queue. However my issue with this library and the reason I haven't 
tried to integrate is simply because the code expressly has no license. 


[1] http://www.liblfds.org/

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.

------=_Part_3360_17828361.1382396325175
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>&gt; The trace_performance functions require manual i=
nstrumentation of the code sections you want to measure</div><div>Ahh a cas=
e of RTFM :)</div><div><br></div><div>&gt; Could you post details about you=
r test setup? Are you still using WebKit for your tests?</div><div>I'm on W=
in7 x64, Core i5 M560, WD 7200 Laptop HDD, NTSF, no virus scanner, truecryp=
t, no defragger.&nbsp;</div><div><br></div><div>I've tried to be a bit smar=
ter with the intent of my code, and this is what I came up with.</div><div>=
<br></div><div>diff --git a/cache.h b/cache.h</div><div>index 4bf19e3..2e9f=
b1f 100644</div><div>--- a/cache.h</div><div>+++ b/cache.h</div><div>@@ -29=
4,7 +294,7 @@ extern void free_name_hash(struct index_state *istate);</div>=
<div>&nbsp;#define active_cache_changed (the_index.cache_changed)</div><div=
>&nbsp;#define active_cache_tree (the_index.cache_tree)</div><div>&nbsp;</d=
iv><div>-#define read_cache() read_index(&amp;the_index)</div><div>+#define=
 read_cache() read_index_preload(&amp;the_index, NULL)</div><div>&nbsp;#def=
ine read_cache_from(path) read_index_from(&amp;the_index, (path))</div><div=
>&nbsp;#define read_cache_preload(pathspec) read_index_preload(&amp;the_ind=
ex, (pathspec))</div><div>&nbsp;#define is_cache_unborn() is_index_unborn(&=
amp;the_index)</div><div>diff --git a/read-cache.c b/read-cache.c</div><div=
>index c3d5e35..5fb2788 100644</div><div>--- a/read-cache.c</div><div>+++ b=
/read-cache.c</div><div>@@ -1866,7 +1866,7 @@ int read_index_unmerged(struc=
t index_state *istate)</div><div>&nbsp;<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>int i;</div><div>&nbsp;<span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">	</span>int unmerged =3D 0;</div><div>&nb=
sp;</div><div>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</=
span>read_index(istate);</div><div>+<span class=3D"Apple-tab-span" style=3D=
"white-space:pre">	</span>read_index_preload(istate, NULL);</div><div>&nbsp=
;<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>for (i =
=3D 0; i &lt; istate-&gt;cache_nr; i++) {</div><div>&nbsp;<span class=3D"Ap=
ple-tab-span" style=3D"white-space:pre">		</span>struct cache_entry *ce =3D=
 istate-&gt;cache[i];</div><div>&nbsp;<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">		</span>struct cache_entry *new_ce;</div><div>--&nbsp=
;</div><div><br></div><div>Interestingly when I run on a cleanly checked ou=
t blink repo my changes seem to make matters worse in terms of performance,=
 but when working on a repo with ignored files in it it seems to work bette=
r. So for point of comparison I decided to run it on a comparison on a repo=
 with working ignored files in it in this case msysgit/git after a 'make in=
stall'. When I get a few hours I'll try to build blink and re-run the numbe=
rs on a much much larger repo.&nbsp;</div><div><br></div><div>This comparis=
on is a average of 3 cold cache runs of the kb/fscache-v4 [a] vs kb/fscache=
-v4 with my above changes applied [b], with preloadindex and fscache set to=
 true.&nbsp;</div><div><br></div><div>For comparison</div><div>git status -=
s</div><div>[a] 3.02s</div><div>[b] 2.92s</div><div><br></div><div>git rese=
t --hard head</div><div>[a] 3.67s</div><div>[b] 3.09s</div><div><br></div><=
div>git add -u</div><div>[a] 2.89s</div><div>[b] 2.08s</div><div><br></div>=
<div><br></div><div>I noticed something interesting. Preload index uses 20 =
threads to do the work. When I was keeping an eye on them in task manager s=
ome threads will finish quite quickly, while others will run a lot longer. =
The way I understand the code at the moment the threads get equal chunks of=
 work to perform. It's quite lilkely that even more performance could be ob=
tained out of preload if the work splitting was 'smarter'. My currently bes=
t idea would be to use something like a lock-free queue to queue up the wor=
k and let the threads get the work of the queue. That way all threads are b=
usy with work for longer. A candidate for the implementation would be libfd=
s [1] queue. However my issue with this library and the reason I haven't tr=
ied to integrate is simply because the code expressly has no license.&nbsp;=
</div><div><br></div><div><br></div><div>[1] http://www.liblfds.org/</div><=
/div>

<p></p>

-- <br />
-- <br />
*** Please reply-to-all at all times ***<br />
*** (do not pretend to know who is subscribed and who is not) ***<br />
*** Please avoid top-posting. ***<br />
The msysGit Wiki is here: <a href=3D"https://github.com/msysgit/msysgit/wik=
i">https://github.com/msysgit/msysgit/wiki</a> - Github accounts are free.<=
br />
&nbsp;<br />
You received this message because you are subscribed to the Google<br />
Groups &quot;msysGit&quot; group.<br />
To post to this group, send email to msysgit@googlegroups.com<br />
To unsubscribe from this group, send email to<br />
msysgit+unsubscribe@googlegroups.com<br />
For more options, and view previous threads, visit this group at<br />
<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den">http:=
//groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><br />
&nbsp;<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;msysGit&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />

------=_Part_3360_17828361.1382396325175--
