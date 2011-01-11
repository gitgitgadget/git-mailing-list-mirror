From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] t4034: bulk verify builtin word regex sanity
Date: Tue, 11 Jan 2011 15:48:11 -0600
Message-ID: <20110111214811.GB29133@burratino>
References: <cover.1292688058.git.trast@student.ethz.ch>
 <854c8b6fa8a368bb34cc22d3fc948ae7136ed177.1292688058.git.trast@student.ethz.ch>
 <20110111214707.GA29133@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Johnson <scottj75074@yahoo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 11 22:48:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcm4t-0002QG-Ei
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 22:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682Ab1AKVs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 16:48:26 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38440 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab1AKVsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 16:48:25 -0500
Received: by qyk12 with SMTP id 12so23725597qyk.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 13:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hqHvaD/OSORxqo9tFJmMI/JBlFEOtZ+LlPpTqGz8WH0=;
        b=Bla4R3IV25lnVg0L6aCoEWQ42C/5easEApuNforq++RHtzoKf8+qKQ4jthPyN+epdM
         IRPitH1Bk0hjbHfnAvrmObW335qUG8ZXLI6EmUZuBHzRbG7m7iyX4nKQMfqO/N6DUU3q
         nktnFD+irrsEi2HMLnmyb2ph1m4vEppje/Xzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I0gYKyZHl1akrHE5IN2wwHGDv9JwBBASyyHCrJjkDsAZKbBjooboAlDN8/MWVSUL85
         Oo6wsS73wrfEblL5737ghqLDF+2wC2fMGbAxhgN7XI2kOPmuU4vE/G9fzIo8QjxoVQID
         e+ClTy+YyZ0qBSVQPB/RKqRuWHz4kdo5FR9sg=
Received: by 10.229.229.83 with SMTP id jh19mr101780qcb.234.1294782504281;
        Tue, 11 Jan 2011 13:48:24 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id nb15sm17736350qcb.38.2011.01.11.13.48.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 13:48:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110111214707.GA29133@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164993>

From: Thomas Rast <trast@student.ethz.ch>
Date: Sat, 18 Dec 2010 17:17:54 +0100

The builtin word regexes should be tested with some simple examples
against simple issues.  Do this in bulk.

Mainly due to a lack of language knowledge and inspiration, most of
the test cases (cpp, csharp, java, objc, pascal, php, python, ruby)
are directly based off a C operator precedence table to verify that
all operators are split correctly.  This means that they are probably
incomplete or inaccurate except for 'cpp' itself.

Still, they are good enough to already have uncovered a typo in the
python and ruby patterns.

'fortran' is based on my anecdotal knowledge of the DO10I parsing
rules, and thus probably useless.  The rest (bibtex, html, tex) are an
ad-hoc test of what I consider important splits in those languages.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4034-diff-words.sh  |   15 +++++++++++++++
 t/t4034/bibtex/expect  |   15 +++++++++++++++
 t/t4034/bibtex/post    |   10 ++++++++++
 t/t4034/bibtex/pre     |    9 +++++++++
 t/t4034/cpp/expect     |   36 ++++++++++++++++++++++++++++++++++++
 t/t4034/cpp/post       |   19 +++++++++++++++++++
 t/t4034/cpp/pre        |   19 +++++++++++++++++++
 t/t4034/csharp/expect  |   35 +++++++++++++++++++++++++++++++++++
 t/t4034/csharp/post    |   18 ++++++++++++++++++
 t/t4034/csharp/pre     |   18 ++++++++++++++++++
 t/t4034/fortran/expect |   10 ++++++++++
 t/t4034/fortran/post   |    5 +++++
 t/t4034/fortran/pre    |    5 +++++
 t/t4034/html/expect    |    8 ++++++++
 t/t4034/html/post      |    3 +++
 t/t4034/html/pre       |    3 +++
 t/t4034/java/expect    |   36 ++++++++++++++++++++++++++++++++++++
 t/t4034/java/post      |   19 +++++++++++++++++++
 t/t4034/java/pre       |   19 +++++++++++++++++++
 t/t4034/objc/expect    |   35 +++++++++++++++++++++++++++++++++++
 t/t4034/objc/post      |   18 ++++++++++++++++++
 t/t4034/objc/pre       |   18 ++++++++++++++++++
 t/t4034/pascal/expect  |   35 +++++++++++++++++++++++++++++++++++
 t/t4034/pascal/post    |   18 ++++++++++++++++++
 t/t4034/pascal/pre     |   18 ++++++++++++++++++
 t/t4034/php/expect     |   35 +++++++++++++++++++++++++++++++++++
 t/t4034/php/post       |   18 ++++++++++++++++++
 t/t4034/php/pre        |   18 ++++++++++++++++++
 t/t4034/python/expect  |   34 ++++++++++++++++++++++++++++++++++
 t/t4034/python/post    |   17 +++++++++++++++++
 t/t4034/python/pre     |   17 +++++++++++++++++
 t/t4034/ruby/expect    |   34 ++++++++++++++++++++++++++++++++++
 t/t4034/ruby/post      |   17 +++++++++++++++++
 t/t4034/ruby/pre       |   17 +++++++++++++++++
 t/t4034/tex/expect     |    9 +++++++++
 t/t4034/tex/post       |    4 ++++
 t/t4034/tex/pre        |    4 ++++
 37 files changed, 668 insertions(+), 0 deletions(-)
 create mode 100644 t/t4034/bibtex/expect
 create mode 100644 t/t4034/bibtex/post
 create mode 100644 t/t4034/bibtex/pre
 create mode 100644 t/t4034/cpp/expect
 create mode 100644 t/t4034/cpp/post
 create mode 100644 t/t4034/cpp/pre
 create mode 100644 t/t4034/csharp/expect
 create mode 100644 t/t4034/csharp/post
 create mode 100644 t/t4034/csharp/pre
 create mode 100644 t/t4034/fortran/expect
 create mode 100644 t/t4034/fortran/post
 create mode 100644 t/t4034/fortran/pre
 create mode 100644 t/t4034/html/expect
 create mode 100644 t/t4034/html/post
 create mode 100644 t/t4034/html/pre
 create mode 100644 t/t4034/java/expect
 create mode 100644 t/t4034/java/post
 create mode 100644 t/t4034/java/pre
 create mode 100644 t/t4034/objc/expect
 create mode 100644 t/t4034/objc/post
 create mode 100644 t/t4034/objc/pre
 create mode 100644 t/t4034/pascal/expect
 create mode 100644 t/t4034/pascal/post
 create mode 100644 t/t4034/pascal/pre
 create mode 100644 t/t4034/php/expect
 create mode 100644 t/t4034/php/post
 create mode 100644 t/t4034/php/pre
 create mode 100644 t/t4034/python/expect
 create mode 100644 t/t4034/python/post
 create mode 100644 t/t4034/python/pre
 create mode 100644 t/t4034/ruby/expect
 create mode 100644 t/t4034/ruby/post
 create mode 100644 t/t4034/ruby/pre
 create mode 100644 t/t4034/tex/expect
 create mode 100644 t/t4034/tex/post
 create mode 100644 t/t4034/tex/pre

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 8096d8a..2647191 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -331,4 +331,19 @@ test_expect_success '--word-diff=none' '
 
 '
 
+word_diff_for_language () {
+	cp "$TEST_DIRECTORY/t4034/$1/pre" \
+		"$TEST_DIRECTORY/t4034/$1/post" \
+		"$TEST_DIRECTORY/t4034/$1/expect" . &&
+	echo "* diff=$1" >.gitattributes &&
+	word_diff --color-words && cp output output.$1
+}
+
+for lang_dir in $TEST_DIRECTORY/t4034/*; do
+	lang=${lang_dir#$TEST_DIRECTORY/t4034/}
+	test_expect_success "diff driver '$lang' has sane word regex" "
+		word_diff_for_language $lang
+	"
+done
+
 test_done
diff --git a/t/t4034/bibtex/expect b/t/t4034/bibtex/expect
new file mode 100644
index 0000000..a157774
--- /dev/null
+++ b/t/t4034/bibtex/expect
@@ -0,0 +1,15 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 95cd55b..ddcba9b 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,9 +1,10 @@<RESET>
+@article{aldous1987uie,<RESET>
+  title={{Ultimate instability of exponential back-off protocol for acknowledgment-based transmission control of random access communication channels}},<RESET>
+  author={Aldous, <RED>D.<RESET><GREEN>David<RESET>},
+  journal={Information Theory, IEEE Transactions on},<RESET>
+  volume={<RED>33<RESET><GREEN>Bogus.<RESET>},
+  number={<RED>2<RESET><GREEN>4<RESET>},
+  pages={219--223},<RESET>
+  year=<GREEN>1987,<RESET>
+<GREEN>  note={This is in fact a rather funny read since ethernet works well in practice. The<RESET> {<RED>1987<RESET><GREEN>\em pre} reference is the right one, however.<RESET>}<RED>,<RESET>
+}<RESET>
diff --git a/t/t4034/bibtex/post b/t/t4034/bibtex/post
new file mode 100644
index 0000000..ddcba9b
--- /dev/null
+++ b/t/t4034/bibtex/post
@@ -0,0 +1,10 @@
+@article{aldous1987uie,
+  title={{Ultimate instability of exponential back-off protocol for acknowledgment-based transmission control of random access communication channels}},
+  author={Aldous, David},
+  journal={Information Theory, IEEE Transactions on},
+  volume={Bogus.},
+  number={4},
+  pages={219--223},
+  year=1987,
+  note={This is in fact a rather funny read since ethernet works well in practice. The {\em pre} reference is the right one, however.}
+}
diff --git a/t/t4034/bibtex/pre b/t/t4034/bibtex/pre
new file mode 100644
index 0000000..95cd55b
--- /dev/null
+++ b/t/t4034/bibtex/pre
@@ -0,0 +1,9 @@
+@article{aldous1987uie,
+  title={{Ultimate instability of exponential back-off protocol for acknowledgment-based transmission control of random access communication channels}},
+  author={Aldous, D.},
+  journal={Information Theory, IEEE Transactions on},
+  volume={33},
+  number={2},
+  pages={219--223},
+  year={1987},
+}
diff --git a/t/t4034/cpp/expect b/t/t4034/cpp/expect
new file mode 100644
index 0000000..37d1ea2
--- /dev/null
+++ b/t/t4034/cpp/expect
@@ -0,0 +1,36 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 23d5c8a..7e8c026 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,19 +1,19 @@<RESET>
+Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <GREEN>bar(x);<RESET> }
+cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
+!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>^<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>|<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>||<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
+<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>,y
+<RED>a<RESET><GREEN>x<RESET>::<RED>b<RESET><GREEN>y<RESET>
diff --git a/t/t4034/cpp/post b/t/t4034/cpp/post
new file mode 100644
index 0000000..7e8c026
--- /dev/null
+++ b/t/t4034/cpp/post
@@ -0,0 +1,19 @@
+Foo() : x(0&42) { bar(x); }
+cout<<"Hello World?\n"<<endl;
+(1) (-1e10) (0xabcdef) 'y'
+[x] x->y x.y
+!x ~x x++ x-- x*y x&y
+x*y x/y x%y
+x+y x-y
+x<<y x>>y
+x<y x<=y x>y x>=y
+x==y x!=y
+x&y
+x^y
+x|y
+x&&y
+x||y
+x?y:z
+x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
+x,y
+x::y
diff --git a/t/t4034/cpp/pre b/t/t4034/cpp/pre
new file mode 100644
index 0000000..23d5c8a
--- /dev/null
+++ b/t/t4034/cpp/pre
@@ -0,0 +1,19 @@
+Foo():x(0&&1){}
+cout<<"Hello World!\n"<<endl;
+1 -1e10 0xabcdef 'x'
+[a] a->b a.b
+!a ~a a++ a-- a*b a&b
+a*b a/b a%b
+a+b a-b
+a<<b a>>b
+a<b a<=b a>b a>=b
+a==b a!=b
+a&b
+a^b
+a|b
+a&&b
+a||b
+a?b:z
+a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
+a,y
+a::b
diff --git a/t/t4034/csharp/expect b/t/t4034/csharp/expect
new file mode 100644
index 0000000..e5d1dd2
--- /dev/null
+++ b/t/t4034/csharp/expect
@@ -0,0 +1,35 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 9106d63..dd5f421 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,18 +1,18 @@<RESET>
+Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <GREEN>bar(x);<RESET> }
+cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
+!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>^<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>|<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>||<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
+<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>,y
diff --git a/t/t4034/csharp/post b/t/t4034/csharp/post
new file mode 100644
index 0000000..dd5f421
--- /dev/null
+++ b/t/t4034/csharp/post
@@ -0,0 +1,18 @@
+Foo() : x(0&42) { bar(x); }
+cout<<"Hello World?\n"<<endl;
+(1) (-1e10) (0xabcdef) 'y'
+[x] x->y x.y
+!x ~x x++ x-- x*y x&y
+x*y x/y x%y
+x+y x-y
+x<<y x>>y
+x<y x<=y x>y x>=y
+x==y x!=y
+x&y
+x^y
+x|y
+x&&y
+x||y
+x?y:z
+x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
+x,y
diff --git a/t/t4034/csharp/pre b/t/t4034/csharp/pre
new file mode 100644
index 0000000..9106d63
--- /dev/null
+++ b/t/t4034/csharp/pre
@@ -0,0 +1,18 @@
+Foo():x(0&&1){}
+cout<<"Hello World!\n"<<endl;
+1 -1e10 0xabcdef 'x'
+[a] a->b a.b
+!a ~a a++ a-- a*b a&b
+a*b a/b a%b
+a+b a-b
+a<<b a>>b
+a<b a<=b a>b a>=b
+a==b a!=b
+a&b
+a^b
+a|b
+a&&b
+a||b
+a?b:z
+a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
+a,y
diff --git a/t/t4034/fortran/expect b/t/t4034/fortran/expect
new file mode 100644
index 0000000..b233dbd
--- /dev/null
+++ b/t/t4034/fortran/expect
@@ -0,0 +1,10 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 87f0d0b..d308da2 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,5 +1,5 @@<RESET>
+print *, "Hello World<RED>!<RESET><GREEN>?<RESET>"
+
+DO10I = 1,10<RESET>
+<RED>DO10I<RESET><GREEN>DO 10 I<RESET> = 1,10
+<RED>DO10I<RESET><GREEN>DO 1 0 I<RESET> = 1,10
diff --git a/t/t4034/fortran/post b/t/t4034/fortran/post
new file mode 100644
index 0000000..d308da2
--- /dev/null
+++ b/t/t4034/fortran/post
@@ -0,0 +1,5 @@
+print *, "Hello World?"
+
+DO10I = 1,10
+DO 10 I = 1,10
+DO 1 0 I = 1,10
diff --git a/t/t4034/fortran/pre b/t/t4034/fortran/pre
new file mode 100644
index 0000000..87f0d0b
--- /dev/null
+++ b/t/t4034/fortran/pre
@@ -0,0 +1,5 @@
+print *, "Hello World!"
+
+DO10I = 1,10
+DO10I = 1,10
+DO10I = 1,10
diff --git a/t/t4034/html/expect b/t/t4034/html/expect
new file mode 100644
index 0000000..447b49a
--- /dev/null
+++ b/t/t4034/html/expect
@@ -0,0 +1,8 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 8ca4aea..46921e5 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,3 +1,3 @@<RESET>
+<tag <GREEN>newattr="newvalue"<RESET>><GREEN>added<RESET> content</tag>
+<tag attr=<RED>"value"<RESET><GREEN>"newvalue"<RESET>><RED>content<RESET><GREEN>changed<RESET></tag>
+<<RED>tag<RESET><GREEN>newtag<RESET>>content <RED>&entity;<RESET><GREEN>&newentity;<RESET><<RED>/tag<RESET><GREEN>/newtag<RESET>>
diff --git a/t/t4034/html/post b/t/t4034/html/post
new file mode 100644
index 0000000..46921e5
--- /dev/null
+++ b/t/t4034/html/post
@@ -0,0 +1,3 @@
+<tag newattr="newvalue">added content</tag>
+<tag attr="newvalue">changed</tag>
+<newtag>content &newentity;</newtag>
diff --git a/t/t4034/html/pre b/t/t4034/html/pre
new file mode 100644
index 0000000..8ca4aea
--- /dev/null
+++ b/t/t4034/html/pre
@@ -0,0 +1,3 @@
+<tag>content</tag>
+<tag attr="value">content</tag>
+<tag>content &entity;</tag>
diff --git a/t/t4034/java/expect b/t/t4034/java/expect
new file mode 100644
index 0000000..37d1ea2
--- /dev/null
+++ b/t/t4034/java/expect
@@ -0,0 +1,36 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 23d5c8a..7e8c026 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,19 +1,19 @@<RESET>
+Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <GREEN>bar(x);<RESET> }
+cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
+!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>^<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>|<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>||<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
+<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>,y
+<RED>a<RESET><GREEN>x<RESET>::<RED>b<RESET><GREEN>y<RESET>
diff --git a/t/t4034/java/post b/t/t4034/java/post
new file mode 100644
index 0000000..7e8c026
--- /dev/null
+++ b/t/t4034/java/post
@@ -0,0 +1,19 @@
+Foo() : x(0&42) { bar(x); }
+cout<<"Hello World?\n"<<endl;
+(1) (-1e10) (0xabcdef) 'y'
+[x] x->y x.y
+!x ~x x++ x-- x*y x&y
+x*y x/y x%y
+x+y x-y
+x<<y x>>y
+x<y x<=y x>y x>=y
+x==y x!=y
+x&y
+x^y
+x|y
+x&&y
+x||y
+x?y:z
+x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
+x,y
+x::y
diff --git a/t/t4034/java/pre b/t/t4034/java/pre
new file mode 100644
index 0000000..23d5c8a
--- /dev/null
+++ b/t/t4034/java/pre
@@ -0,0 +1,19 @@
+Foo():x(0&&1){}
+cout<<"Hello World!\n"<<endl;
+1 -1e10 0xabcdef 'x'
+[a] a->b a.b
+!a ~a a++ a-- a*b a&b
+a*b a/b a%b
+a+b a-b
+a<<b a>>b
+a<b a<=b a>b a>=b
+a==b a!=b
+a&b
+a^b
+a|b
+a&&b
+a||b
+a?b:z
+a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
+a,y
+a::b
diff --git a/t/t4034/objc/expect b/t/t4034/objc/expect
new file mode 100644
index 0000000..e5d1dd2
--- /dev/null
+++ b/t/t4034/objc/expect
@@ -0,0 +1,35 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 9106d63..dd5f421 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,18 +1,18 @@<RESET>
+Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) { <GREEN>bar(x);<RESET> }
+cout<<"Hello World<RED>!<RESET><GREEN>?<RESET>\n"<<endl;
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
+!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>^<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>|<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>||<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
+<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>,y
diff --git a/t/t4034/objc/post b/t/t4034/objc/post
new file mode 100644
index 0000000..dd5f421
--- /dev/null
+++ b/t/t4034/objc/post
@@ -0,0 +1,18 @@
+Foo() : x(0&42) { bar(x); }
+cout<<"Hello World?\n"<<endl;
+(1) (-1e10) (0xabcdef) 'y'
+[x] x->y x.y
+!x ~x x++ x-- x*y x&y
+x*y x/y x%y
+x+y x-y
+x<<y x>>y
+x<y x<=y x>y x>=y
+x==y x!=y
+x&y
+x^y
+x|y
+x&&y
+x||y
+x?y:z
+x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
+x,y
diff --git a/t/t4034/objc/pre b/t/t4034/objc/pre
new file mode 100644
index 0000000..9106d63
--- /dev/null
+++ b/t/t4034/objc/pre
@@ -0,0 +1,18 @@
+Foo():x(0&&1){}
+cout<<"Hello World!\n"<<endl;
+1 -1e10 0xabcdef 'x'
+[a] a->b a.b
+!a ~a a++ a-- a*b a&b
+a*b a/b a%b
+a+b a-b
+a<<b a>>b
+a<b a<=b a>b a>=b
+a==b a!=b
+a&b
+a^b
+a|b
+a&&b
+a||b
+a?b:z
+a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
+a,y
diff --git a/t/t4034/pascal/expect b/t/t4034/pascal/expect
new file mode 100644
index 0000000..2ce4230
--- /dev/null
+++ b/t/t4034/pascal/expect
@@ -0,0 +1,35 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 077046c..8865e6b 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,18 +1,18 @@<RESET>
+writeln("Hello World<RED>!<RESET><GREEN>?<RESET>");
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
+!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>^<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>|<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>||<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
+<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>,y
+<RED>a<RESET><GREEN>x<RESET>::<RED>b<RESET><GREEN>y<RESET>
diff --git a/t/t4034/pascal/post b/t/t4034/pascal/post
new file mode 100644
index 0000000..8865e6b
--- /dev/null
+++ b/t/t4034/pascal/post
@@ -0,0 +1,18 @@
+writeln("Hello World?");
+(1) (-1e10) (0xabcdef) 'y'
+[x] x->y x.y
+!x ~x x++ x-- x*y x&y
+x*y x/y x%y
+x+y x-y
+x<<y x>>y
+x<y x<=y x>y x>=y
+x==y x!=y
+x&y
+x^y
+x|y
+x&&y
+x||y
+x?y:z
+x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
+x,y
+x::y
diff --git a/t/t4034/pascal/pre b/t/t4034/pascal/pre
new file mode 100644
index 0000000..077046c
--- /dev/null
+++ b/t/t4034/pascal/pre
@@ -0,0 +1,18 @@
+writeln("Hello World!");
+1 -1e10 0xabcdef 'x'
+[a] a->b a.b
+!a ~a a++ a-- a*b a&b
+a*b a/b a%b
+a+b a-b
+a<<b a>>b
+a<b a<=b a>b a>=b
+a==b a!=b
+a&b
+a^b
+a|b
+a&&b
+a||b
+a?b:z
+a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
+a,y
+a::b
diff --git a/t/t4034/php/expect b/t/t4034/php/expect
new file mode 100644
index 0000000..0404408
--- /dev/null
+++ b/t/t4034/php/expect
@@ -0,0 +1,35 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index cf6e06b..4420a49 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,18 +1,18 @@<RESET>
+<GREEN>(<RESET>$var<GREEN>)<RESET> $ var
+<?="Hello World<RED>!<RESET><GREEN>?<RESET>"?>
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
+!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>^<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>|<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>||<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
+<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>,y
diff --git a/t/t4034/php/post b/t/t4034/php/post
new file mode 100644
index 0000000..4420a49
--- /dev/null
+++ b/t/t4034/php/post
@@ -0,0 +1,18 @@
+($var) $ var
+<?="Hello World?"?>
+(1) (-1e10) (0xabcdef) 'y'
+[x] x->y x.y
+!x ~x x++ x-- x*y x&y
+x*y x/y x%y
+x+y x-y
+x<<y x>>y
+x<y x<=y x>y x>=y
+x==y x!=y
+x&y
+x^y
+x|y
+x&&y
+x||y
+x?y:z
+x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
+x,y
diff --git a/t/t4034/php/pre b/t/t4034/php/pre
new file mode 100644
index 0000000..cf6e06b
--- /dev/null
+++ b/t/t4034/php/pre
@@ -0,0 +1,18 @@
+$var $var
+<?= "Hello World!" ?>
+1 -1e10 0xabcdef 'x'
+[a] a->b a.b
+!a ~a a++ a-- a*b a&b
+a*b a/b a%b
+a+b a-b
+a<<b a>>b
+a<b a<=b a>b a>=b
+a==b a!=b
+a&b
+a^b
+a|b
+a&&b
+a||b
+a?b:z
+a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
+a,y
diff --git a/t/t4034/python/expect b/t/t4034/python/expect
new file mode 100644
index 0000000..8abb8a4
--- /dev/null
+++ b/t/t4034/python/expect
@@ -0,0 +1,34 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 438f776..68baf34 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,17 +1,17 @@<RESET>
+print<RED>u<RESET> "Hello World<RED>!<RESET><GREEN>?<RESET>\n"<GREEN>; print<RESET>
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>) u<RESET>'<RED>x<RESET><GREEN>y<RESET>'
+[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
+!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>^<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>|<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>||<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>?<RED>b<RESET><GREEN>y<RESET>:z
+<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>,y
diff --git a/t/t4034/python/post b/t/t4034/python/post
new file mode 100644
index 0000000..68baf34
--- /dev/null
+++ b/t/t4034/python/post
@@ -0,0 +1,17 @@
+print "Hello World?\n"; print
+(1) (-1e10) (0xabcdef) u'y'
+[x] x->y x.y
+!x ~x x++ x-- x*y x&y
+x*y x/y x%y
+x+y x-y
+x<<y x>>y
+x<y x<=y x>y x>=y
+x==y x!=y
+x&y
+x^y
+x|y
+x&&y
+x||y
+x?y:z
+x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
+x,y
diff --git a/t/t4034/python/pre b/t/t4034/python/pre
new file mode 100644
index 0000000..438f776
--- /dev/null
+++ b/t/t4034/python/pre
@@ -0,0 +1,17 @@
+print u"Hello World!\n"
+1 -1e10 0xabcdef 'x'
+[a] a->b a.b
+!a ~a a++ a-- a*b a&b
+a*b a/b a%b
+a+b a-b
+a<<b a>>b
+a<b a<=b a>b a>=b
+a==b a!=b
+a&b
+a^b
+a|b
+a&&b
+a||b
+a?b:z
+a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
+a,y
diff --git a/t/t4034/ruby/expect b/t/t4034/ruby/expect
new file mode 100644
index 0000000..16e1dd5
--- /dev/null
+++ b/t/t4034/ruby/expect
@@ -0,0 +1,34 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 30ed9a1..7678f14 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,17 +1,17 @@<RESET>
+10.downto(1) {|<RED>x<RESET><GREEN>y<RESET>| puts <RED>x<RESET><GREEN>y<RESET>}
+<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
+[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
+!<RED>a<RESET><GREEN>x<RESET> ~<RED>a a<RESET><GREEN>x x<RESET>++ <RED>a<RESET><GREEN>x<RESET>-- <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>^<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>|<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>||<RED>b<RESET>
+<RED>a?b<RESET><GREEN>y<RESET>
+<GREEN>x?y<RESET>:z
+<RED>a<RESET><GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>,y
diff --git a/t/t4034/ruby/post b/t/t4034/ruby/post
new file mode 100644
index 0000000..7678f14
--- /dev/null
+++ b/t/t4034/ruby/post
@@ -0,0 +1,17 @@
+10.downto(1) {|y| puts y}
+(1) (-1e10) (0xabcdef) 'y'
+[x] x->y x.y
+!x ~x x++ x-- x*y x&y
+x*y x/y x%y
+x+y x-y
+x<<y x>>y
+x<y x<=y x>y x>=y
+x==y x!=y
+x&y
+x^y
+x|y
+x&&y
+x||y
+x?y:z
+x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
+x,y
diff --git a/t/t4034/ruby/pre b/t/t4034/ruby/pre
new file mode 100644
index 0000000..30ed9a1
--- /dev/null
+++ b/t/t4034/ruby/pre
@@ -0,0 +1,17 @@
+10.downto(1) {|x| puts x}
+1 -1e10 0xabcdef 'x'
+[a] a->b a.b
+!a ~a a++ a-- a*b a&b
+a*b a/b a%b
+a+b a-b
+a<<b a>>b
+a<b a<=b a>b a>=b
+a==b a!=b
+a&b
+a^b
+a|b
+a&&b
+a||b
+a?b:z
+a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
+a,y
diff --git a/t/t4034/tex/expect b/t/t4034/tex/expect
new file mode 100644
index 0000000..604969b
--- /dev/null
+++ b/t/t4034/tex/expect
@@ -0,0 +1,9 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 2b2dfcb..65cab61 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,4 +1,4 @@<RESET>
+\section{Something <GREEN>new<RESET>}
+<RED>\emph<RESET><GREEN>\textbf<RESET>{Macro style}
+{<RED>\em<RESET><GREEN>\bfseries<RESET> State toggle style}
+\\[<RED>1em<RESET><GREEN>1cm<RESET>]
diff --git a/t/t4034/tex/post b/t/t4034/tex/post
new file mode 100644
index 0000000..65cab61
--- /dev/null
+++ b/t/t4034/tex/post
@@ -0,0 +1,4 @@
+\section{Something new}
+\textbf{Macro style}
+{\bfseries State toggle style}
+\\[1cm]
diff --git a/t/t4034/tex/pre b/t/t4034/tex/pre
new file mode 100644
index 0000000..2b2dfcb
--- /dev/null
+++ b/t/t4034/tex/pre
@@ -0,0 +1,4 @@
+\section{Something}
+\emph{Macro style}
+{\em State toggle style}
+\\[1em]
-- 
1.7.4.rc1
