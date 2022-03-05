Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23921C433F5
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 10:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiCEKRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Mar 2022 05:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiCEKRp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Mar 2022 05:17:45 -0500
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607CF457B0
        for <git@vger.kernel.org>; Sat,  5 Mar 2022 02:16:54 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4K9gcg4T4mz5tlB;
        Sat,  5 Mar 2022 11:16:51 +0100 (CET)
Message-ID: <79bd770e-74f1-edf8-884b-c0f916732ce0@kdbg.org>
Date:   Sat, 5 Mar 2022 11:16:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [GSoC][PATCH 1/1] Add a diff driver for JavaScript languages.
Content-Language: en-US
To:     xing zhi jiang <a97410985new@gmail.com>
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220304130854.857746-2-a97410985new@gmail.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20220304130854.857746-2-a97410985new@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your contribution!

Am 04.03.22 um 14:08 schrieb xing zhi jiang:
> In the xfunction part that matches normal functions,
> a variable declaration with an assignment of function, the function declaration
> in the class, and also the function is object literal's property.

On the first read, I stumbled over the last half-sentence. Is this
JavaScript-lingo for the construct

   x = { foo: function() { ... } }

A parenthetical note in this regard would be helpful.

> And in the word regex part, that matches numbers, punctuations, and also the
> JavaScript identifier.
> This part heavily references the formal ECMA sepcification[1].
> 
> [1]https://262.ecma-international.org/12.0/#sec-ecmascript-language-lexical-grammar

After having seen the regex, to follow the syntax specification is
unnecessarily tight. If you follow my suggestions, the note should
probably be rewritten, but keeping the link to the language reference is
certainly helpful.

> 
> Signed-off-by: xing zhi jiang <a97410985new@gmail.com>
> ---
>  .gitignore                                    |  1 +
>  Documentation/gitattributes.txt               |  2 +
>  ...avascript-assignment-of-anonymous-function |  4 ++
>  .../javascript-assignment-of-arrow-function   |  4 ++
>  .../javascript-assignment-of-named-function   |  4 ++
>  t/t4018/javascript-async-function             |  4 ++
>  t/t4018/javascript-export-async-function      |  4 ++
>  t/t4018/javascript-export-function            |  4 ++
>  t/t4018/javascript-exports-anomyous-function  |  4 ++
>  .../javascript-exports-anomyous-function-2    |  4 ++
>  t/t4018/javascript-exports-function           |  4 ++
>  t/t4018/javascript-function                   |  4 ++
>  t/t4018/javascript-function-2                 | 10 ++++
>  t/t4018/javascript-function-belong-to-IIFE    |  6 +++
>  t/t4018/javascript-function-in-class          |  6 +++
>  t/t4018/javascript-function-in-class-2        | 11 ++++
>  t/t4018/javascript-function-in-object-literal |  7 +++
>  t/t4018/javascript-generator-function         |  4 ++
>  t/t4018/javascript-generator-function-2       |  4 ++
>  t/t4018/javascript-getter-function-in-class   |  6 +++
>  t/t4018/javascript-setter-function-in-class   |  6 +++
>  .../javascript-skip-function-call-statement   |  7 +++
>  t/t4018/javascript-skip-keywords              | 34 ++++++++++++
>  t/t4018/javascript-static-function-in-class   |  6 +++
>  t/t4034-diff-words.sh                         |  1 +
>  t/t4034/javascript/expect                     | 52 +++++++++++++++++++
>  t/t4034/javascript/post                       | 32 ++++++++++++
>  t/t4034/javascript/pre                        | 32 ++++++++++++
>  userdiff.c                                    | 38 ++++++++++++++
>  29 files changed, 305 insertions(+)
>  create mode 100644 t/t4018/javascript-assignment-of-anonymous-function
>  create mode 100644 t/t4018/javascript-assignment-of-arrow-function
>  create mode 100644 t/t4018/javascript-assignment-of-named-function
>  create mode 100644 t/t4018/javascript-async-function
>  create mode 100644 t/t4018/javascript-export-async-function
>  create mode 100644 t/t4018/javascript-export-function
>  create mode 100644 t/t4018/javascript-exports-anomyous-function
>  create mode 100644 t/t4018/javascript-exports-anomyous-function-2
>  create mode 100644 t/t4018/javascript-exports-function
>  create mode 100644 t/t4018/javascript-function
>  create mode 100644 t/t4018/javascript-function-2
>  create mode 100644 t/t4018/javascript-function-belong-to-IIFE
>  create mode 100644 t/t4018/javascript-function-in-class
>  create mode 100644 t/t4018/javascript-function-in-class-2
>  create mode 100644 t/t4018/javascript-function-in-object-literal
>  create mode 100644 t/t4018/javascript-generator-function
>  create mode 100644 t/t4018/javascript-generator-function-2
>  create mode 100644 t/t4018/javascript-getter-function-in-class
>  create mode 100644 t/t4018/javascript-setter-function-in-class
>  create mode 100644 t/t4018/javascript-skip-function-call-statement
>  create mode 100644 t/t4018/javascript-skip-keywords
>  create mode 100644 t/t4018/javascript-static-function-in-class
>  create mode 100644 t/t4034/javascript/expect
>  create mode 100644 t/t4034/javascript/post
>  create mode 100644 t/t4034/javascript/pre
> 
> diff --git a/.gitignore b/.gitignore
> index f817c509ec..de628c53f8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -244,3 +244,4 @@ Release/
>  /git.VC.db
>  *.dSYM
>  /contrib/buildsystems/out
> +/.cache
> \ No newline at end of file

Do not include this change. It does not belong to this commit.

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 60984a4682..f6554a4651 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -828,6 +828,8 @@ patterns are available:
>  
>  - `java` suitable for source code in the Java language.
>  
> +- `javascript suitable for source code in the JavaScript language.

Please do not forget the closing quote.

> +
>  - `markdown` suitable for Markdown documents.
>  
>  - `matlab` suitable for source code in the MATLAB and Octave languages.
> diff --git a/t/t4018/javascript-assignment-of-anonymous-function b/t/t4018/javascript-assignment-of-anonymous-function
> new file mode 100644
> index 0000000000..5d4701e84c
> --- /dev/null
> +++ b/t/t4018/javascript-assignment-of-anonymous-function
> @@ -0,0 +1,4 @@
> +const RIGHT = function (a, b) {
> +	
> +    return a + b; // ChangeMe
> +};
> \ No newline at end of file

Notice this "No newline at end of file". Please complete the last line
of the file, i.e. do add the last line break. Same for all other new
files introduced in this patch.

> diff --git a/t/t4018/javascript-assignment-of-arrow-function b/t/t4018/javascript-assignment-of-arrow-function
> new file mode 100644
> index 0000000000..6ab73ccb7a
> --- /dev/null
> +++ b/t/t4018/javascript-assignment-of-arrow-function
> @@ -0,0 +1,4 @@
> +const RIGHT = (a, b) => {
> +	
> +    return a + b; // ChangeMe
> +};
> \ No newline at end of file
> diff --git a/t/t4018/javascript-assignment-of-named-function b/t/t4018/javascript-assignment-of-named-function
> new file mode 100644
> index 0000000000..85d43123a6
> --- /dev/null
> +++ b/t/t4018/javascript-assignment-of-named-function
> @@ -0,0 +1,4 @@
> +const RIGHT = function test (a, b) {
> +	
> +    return a + b; // ChangeMe
> +};
> \ No newline at end of file
> diff --git a/t/t4018/javascript-async-function b/t/t4018/javascript-async-function
> new file mode 100644
> index 0000000000..ebc7c8c05b
> --- /dev/null
> +++ b/t/t4018/javascript-async-function
> @@ -0,0 +1,4 @@
> +async function RIGHT(a, b) {
> +  
> +  return a + b; // ChangeMe
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-export-async-function b/t/t4018/javascript-export-async-function
> new file mode 100644
> index 0000000000..3cd60b7980
> --- /dev/null
> +++ b/t/t4018/javascript-export-async-function
> @@ -0,0 +1,4 @@
> +export async function RIGHT(a, b) {
> +  
> +  return a + b; // ChangeMe
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-export-function b/t/t4018/javascript-export-function
> new file mode 100644
> index 0000000000..177ddec779
> --- /dev/null
> +++ b/t/t4018/javascript-export-function
> @@ -0,0 +1,4 @@
> +export function RIGHT(a, b) {
> +  
> +  return a + b; // ChangeMe
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-exports-anomyous-function b/t/t4018/javascript-exports-anomyous-function
> new file mode 100644
> index 0000000000..45b0ecd659
> --- /dev/null
> +++ b/t/t4018/javascript-exports-anomyous-function
> @@ -0,0 +1,4 @@
> +exports.setFlagged = RIGHT => {
> +	
> +    return ChangeMe;
> +};
> \ No newline at end of file
> diff --git a/t/t4018/javascript-exports-anomyous-function-2 b/t/t4018/javascript-exports-anomyous-function-2
> new file mode 100644
> index 0000000000..0c572bfde3
> --- /dev/null
> +++ b/t/t4018/javascript-exports-anomyous-function-2
> @@ -0,0 +1,4 @@
> +exports.RIGHT = (a, b, runtime) => {
> +	
> +    return ChangeMe;
> +};
> \ No newline at end of file
> diff --git a/t/t4018/javascript-exports-function b/t/t4018/javascript-exports-function
> new file mode 100644
> index 0000000000..f1587fddac
> --- /dev/null
> +++ b/t/t4018/javascript-exports-function
> @@ -0,0 +1,4 @@
> +exports.RIGHT = function(document) {
> +    
> +    return ChangeMe
> +}

Not a particularly important point, but the correct syntax requires a
semicolon here, I guess.

> \ No newline at end of file
> diff --git a/t/t4018/javascript-function b/t/t4018/javascript-function
> new file mode 100644
> index 0000000000..dd8ab54c9b
> --- /dev/null
> +++ b/t/t4018/javascript-function
> @@ -0,0 +1,4 @@
> +function RIGHT(a, b) {
> +
> +  return a + b; // ChangeMe
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-function-2 b/t/t4018/javascript-function-2
> new file mode 100644
> index 0000000000..d72063cdf0
> --- /dev/null
> +++ b/t/t4018/javascript-function-2
> @@ -0,0 +1,10 @@
> +function test(a, b) {
> +  return {
> +			RIGHT: function () {
> +				currentUpdateRemovedChunks.forEach(function (chunkId) {

This line is a decoy that is not picked up. Nice.

> +					delete $installedChunks$[chunkId];
> +				});
> +				currentUpdateRemovedChunks = ChangeMe;
> +   }
> +  }
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-function-belong-to-IIFE b/t/t4018/javascript-function-belong-to-IIFE
> new file mode 100644
> index 0000000000..6a80118e8a
> --- /dev/null
> +++ b/t/t4018/javascript-function-belong-to-IIFE
> @@ -0,0 +1,6 @@
> +(function () {
> +  this.$RIGHT = function (needle, modifier) {
> +      let a = 5;
> +      return ChangeMe;
> +  };
> +}).call(aaaa.prototype);
> \ No newline at end of file
> diff --git a/t/t4018/javascript-function-in-class b/t/t4018/javascript-function-in-class
> new file mode 100644
> index 0000000000..4b2f9c37e0
> --- /dev/null
> +++ b/t/t4018/javascript-function-in-class
> @@ -0,0 +1,6 @@
> +class Test {
> +  RIGHT() {
> +    let a = 4;
> +    let b = ChangeMe;
> +  }
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-function-in-class-2 b/t/t4018/javascript-function-in-class-2
> new file mode 100644
> index 0000000000..402c4aecc3
> --- /dev/null
> +++ b/t/t4018/javascript-function-in-class-2
> @@ -0,0 +1,11 @@
> +class Test {
> +  RIGHT(
> +      aaaaaaaaaa,
> +      bbbbbbbbbb,
> +      cccccccccc,
> +      dddddddddd
> +  ) {
> +    let a = 4;
> +    let b = ChangeMe;
> +  }
> +}
> \ No newline at end of file

In the above two, we see class member functions. Is there a test case
where the function parameter is on the same line as the function name or
is that one of the difficult cases?

> diff --git a/t/t4018/javascript-function-in-object-literal b/t/t4018/javascript-function-in-object-literal
> new file mode 100644
> index 0000000000..37f7ef72ee
> --- /dev/null
> +++ b/t/t4018/javascript-function-in-object-literal
> @@ -0,0 +1,7 @@
> +const obj = {
> +    RIGHT: function (elems, callback, arg) {
> +        var length, value;
> +        // ...
> +        return ChangeMe
> +    }
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-generator-function b/t/t4018/javascript-generator-function
> new file mode 100644
> index 0000000000..caf0b9f04f
> --- /dev/null
> +++ b/t/t4018/javascript-generator-function
> @@ -0,0 +1,4 @@
> +function* RIGHT(a, b) {
> +  
> +  return a + b; // ChangeMe
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-generator-function-2 b/t/t4018/javascript-generator-function-2
> new file mode 100644
> index 0000000000..6fc3b74a0d
> --- /dev/null
> +++ b/t/t4018/javascript-generator-function-2
> @@ -0,0 +1,4 @@
> +function *RIGHT(a, b) {
> +  
> +  return a + b; // ChangeMe
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-getter-function-in-class b/t/t4018/javascript-getter-function-in-class
> new file mode 100644
> index 0000000000..0159541be7
> --- /dev/null
> +++ b/t/t4018/javascript-getter-function-in-class
> @@ -0,0 +1,6 @@
> +class Test {
> +  get RIGHT() {
> +    let a = 4;
> +    let b = ChangeMe;
> +  }
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-setter-function-in-class b/t/t4018/javascript-setter-function-in-class
> new file mode 100644
> index 0000000000..3e17f47aa2
> --- /dev/null
> +++ b/t/t4018/javascript-setter-function-in-class
> @@ -0,0 +1,6 @@
> +class Test {
> +  set RIGHT() {
> +    let a = 4;
> +    let b = ChangeMe;
> +  }
> +}
> \ No newline at end of file
> diff --git a/t/t4018/javascript-skip-function-call-statement b/t/t4018/javascript-skip-function-call-statement
> new file mode 100644
> index 0000000000..84b51514d2
> --- /dev/null
> +++ b/t/t4018/javascript-skip-function-call-statement
> @@ -0,0 +1,7 @@
> +class Test {
> +  static RIGHT() {
> +    haha();
> +    haha2()
> +    let b = ChangeMe;
> +  }
> +}

Good call to include this test case!

> \ No newline at end of file
> diff --git a/t/t4018/javascript-skip-keywords b/t/t4018/javascript-skip-keywords
> new file mode 100644
> index 0000000000..1ed56c08de
> --- /dev/null
> +++ b/t/t4018/javascript-skip-keywords
> @@ -0,0 +1,34 @@
> +function RIGHT(a, b) {
> +  import("./async1")
> +  if (a > 1) {
> +    // ...
> +  }
> +  do {
> +    // ...
> +  } while (i < 5);
> +  for (const element of array1) {
> +    console.log(element)
> +  }
> +  with(o) {
> +    console.log(x)
> +  }
> +  switch (expr) {
> +    case 'a':
> +      // ...
> +      break;
> +    case 'b':
> +      // ...
> +      break;
> +    default:
> +      // ...
> +  }
> +  try {
> +    // ...
> +    return (a + c)
> +  } 
> +  catch (error) {
> +    // ...
> +  }
> +
> +  return a + b; // ChangeMe
> +}

Very well!

> \ No newline at end of file
> diff --git a/t/t4018/javascript-static-function-in-class b/t/t4018/javascript-static-function-in-class
> new file mode 100644
> index 0000000000..efbccaf113
> --- /dev/null
> +++ b/t/t4018/javascript-static-function-in-class
> @@ -0,0 +1,6 @@
> +class Test {
> +  static RIGHT() {
> +    let a = 4;
> +    let b = ChangeMe;
> +  }
> +}
> \ No newline at end of file
> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> index d5abcf4b4c..33073edeca 100755
> --- a/t/t4034-diff-words.sh
> +++ b/t/t4034-diff-words.sh
> @@ -324,6 +324,7 @@ test_language_driver dts
>  test_language_driver fortran
>  test_language_driver html
>  test_language_driver java
> +test_language_driver javascript
>  test_language_driver matlab
>  test_language_driver objc
>  test_language_driver pascal
> diff --git a/t/t4034/javascript/expect b/t/t4034/javascript/expect
> new file mode 100644
> index 0000000000..602513c651
> --- /dev/null
> +++ b/t/t4034/javascript/expect
> @@ -0,0 +1,52 @@
> +<BOLD>diff --git a/pre b/post<RESET>
> +<BOLD>index b72238f..8bc3e3a 100644<RESET>
> +<BOLD>--- a/pre<RESET>
> +<BOLD>+++ b/post<RESET>
> +<CYAN>@@ -1,32 +1,32 @@<RESET>
> +// DecimalLiteral<RESET>
> +<RED>123<RESET>
> +<RED>0.123<RESET>
> +<RED>0.123e+5<RESET>
> +<RED>0.123E+5<RESET>
> +<RED>0.123e5<RESET>
> +<RED>1222222222222222223334444n<RESET><GREEN>124<RESET>
> +<GREEN>0.124<RESET>
> +<GREEN>0.123e-5<RESET>
> +<GREEN>0.123E-5<RESET>
> +<GREEN>0.123E5<RESET>
> +<GREEN>12222222222222222233344445n<RESET>
> +// HexIntegerLiteral<RESET>
> +<RED>0x10<RESET>
> +<RED>0X6Fa1<RESET>
> +<RED>0x123_456<RESET>
> +<RED>0x1234182989812f1289an<RESET><GREEN>0x11<RESET>
> +<GREEN>0X5Fa1<RESET>
> +<GREEN>0x123_756<RESET>
> +<GREEN>0x1234182989812f1289bn<RESET>
> +// OctalIntegerLiteral<RESET>
> +<RED>05<RESET>
> +<RED>0o6<RESET>
> +<RED>0O7<RESET>
> +<RED>0512_567<RESET>
> +<RED>0o424242424242424242424242424242666666n<RESET><GREEN>06<RESET>
> +<GREEN>0o5<RESET>
> +<GREEN>0O4<RESET>
> +<GREEN>0511_567<RESET>
> +<GREEN>0o424242424242424242424242424242666667n<RESET>
> +// BinaryIntegerLiteral<RESET>
> +<RED>0b1001<RESET>
> +<RED>0B0110<RESET>
> +<RED>0b0001_1001_0011<RESET>
> +<RED>0b1111111111111111111111111111111111111n<RESET><GREEN>0b1101<RESET>
> +<GREEN>0B0010<RESET>
> +<GREEN>0b0001_1101_0011<RESET>
> +<GREEN>0b11111111111111000011111111111111111n<RESET>
> +// punctuations<RESET>
> +{<RED>a<RESET><GREEN>b<RESET>} (<RED>a<RESET><GREEN>b<RESET>)
> +<RED>a<RESET><GREEN>b<RESET>;
> +[<RED>1,<RESET>2<GREEN>,3<RESET>]
> +[<RED>1, 2,<RESET> ...<RED>params<RESET><GREEN>params_v2<RESET> ]
> +a<RED><=<RESET><GREEN>=<RESET>2 a<RED>>=<RESET><GREEN>=<RESET>2 a<RED>==<RESET><GREEN>=<RESET>2 a<RED>!=<RESET><GREEN>=<RESET>2 a<RED>===<RESET><GREEN>=<RESET>2 a<RED>!==<RESET><GREEN>=<RESET>2 a<RED>^=<RESET><GREEN>=<RESET>2 a<RED>=><RESET><GREEN>=<RESET>2
> +a<RED>+=<RESET><GREEN>-=<RESET>b a<RED>*=<RESET><GREEN>%=<RESET>b a<RED>**=<RESET><GREEN>&&=<RESET>b a<RED>||=<RESET><GREEN>|=<RESET>b
> +b<RED>+<RESET><GREEN>-<RESET>c a<RED>--<RESET><GREEN>++<RESET> a<RED>>><RESET><GREEN><<<RESET>b a<RED>>>><RESET><GREEN>>>>=<RESET>b a<RED>>>=<RESET><GREEN><<=<RESET>b
> +a<RED>&&<RESET><GREEN>&<RESET>b a<RED>||<RESET><GREEN>|<RESET>b a<RED>&&=<RESET><GREEN>??=<RESET>b

This looks good! I see many changes in operators being tested.

> diff --git a/t/t4034/javascript/post b/t/t4034/javascript/post
> new file mode 100644
> index 0000000000..8bc3e3af12
> --- /dev/null
> +++ b/t/t4034/javascript/post
> @@ -0,0 +1,32 @@
> +// DecimalLiteral
> +124
> +0.124
> +0.123e-5
> +0.123E-5
> +0.123E5
> +12222222222222222233344445n
> +// HexIntegerLiteral
> +0x11
> +0X5Fa1
> +0x123_756
> +0x1234182989812f1289bn
> +// OctalIntegerLiteral
> +06
> +0o5
> +0O4
> +0511_567
> +0o424242424242424242424242424242666667n
> +// BinaryIntegerLiteral
> +0b1101
> +0B0010
> +0b0001_1101_0011
> +0b11111111111111000011111111111111111n
> +// punctuations
> +{b} (b)
> +b;
> +[2,3]
> +[ ...params_v2 ]
> +a=2 a=2 a=2 a=2 a=2 a=2 a=2 a=2
> +a-=b a%=b a&&=b a|=b
> +b-c a++ a<<b a>>>=b a<<=b
> +a&b a|b a??=b
> \ No newline at end of file
> diff --git a/t/t4034/javascript/pre b/t/t4034/javascript/pre
> new file mode 100644
> index 0000000000..b72238f779
> --- /dev/null
> +++ b/t/t4034/javascript/pre
> @@ -0,0 +1,32 @@
> +// DecimalLiteral
> +123
> +0.123
> +0.123e+5
> +0.123E+5
> +0.123e5
> +1222222222222222223334444n
> +// HexIntegerLiteral
> +0x10
> +0X6Fa1
> +0x123_456
> +0x1234182989812f1289an
> +// OctalIntegerLiteral
> +05
> +0o6
> +0O7
> +0512_567
> +0o424242424242424242424242424242666666n
> +// BinaryIntegerLiteral
> +0b1001
> +0B0110
> +0b0001_1001_0011
> +0b1111111111111111111111111111111111111n
> +// punctuations
> +{a} (a)
> +a;
> +[1,2]
> +[ 1, 2, ...params ]
> +a<=2 a>=2 a==2 a!=2 a===2 a!==2 a^=2 a=>2
> +a+=b a*=b a**=b a||=b
> +b+c a-- a>>b a>>>b a>>=b
> +a&&b a||b a&&=b
> \ No newline at end of file
> diff --git a/userdiff.c b/userdiff.c
> index 8578cb0d12..a6a341e3c1 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -168,6 +168,44 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +
> +PATTERNS("javascript",
> +	 /* don't match the expression may contain parenthesis, because it is not a function declaration */
> +	 "!^[ \t]*(if|do|while|for|with|switch|catch|import|return)\n"

These will not match

	}while (expr)

note the absent blank before the keyword, but that is an acceptable
trade-off to keep things simple. Good.

> +	 /* don't match statement */
> +	 "!^.*;[ \t]*\n"

This regexp can be reduced to

	"!;\n"

no?

> +	 /* match normal function */
> +	 "^[\t ]*((export[\t ]+)?(async[\t ]+)?function[\t ]*([\t ]*\\*[\t ]*|[\t ]*)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)\n"

Good. One note though: keyword "function" can optionally be followed by
an asterisk '*'. You can probably simplify the middle part to

	...function[\t *]*...identifier...

> +	 /* match JavaScript variable declaration with a lambda expression */
> +	 "^[\t ]*((const|let|var)[\t ]*[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*"
> +	 "(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*[\t ])[\t ]*=>[\t ]*\\{?)\n"

Let's break this down:

	"^[\t ]*"
	    "("
	        "(const|let|var)[\t ]*"
	        "[$_[:alpha:]][$_[:alnum:]]*[\t ]*"
	        "=[\t ]*"
	        "("
	            "\\(.*\\)"
	            "|"
	            "[$_[:alpha:]][$_[:alnum:]]*[\t ]"
	        ")[\t ]*"
	        "=>[\t ]*"
	        "\\{?"
	    ")\n"

Can you not have

	var f = foo=>{

because I see that whitespace is required between the identifier and "=>"?

> +	 /* match exports for anonymous fucntion */
> +	 "^[\t ]*(exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"

Here, whitespace is not required. Is the above an oversight?

BTW, can keyword "exports" be used for something other than functions?

> +	 /* match assign function to LHS */
> +	 "^(.*=[\t ]*function[\t ]*([$_[:alpha:]][$_[:alnum:]]*)?[\t ]*\\(.*)\n"

This makes me think that whenever keyword "function" appears, then we
see the beginning of a function. This would allow a simple pattern
upfront that picks out all functions defined with this keyword, and all
other patterns need only be concerned with the exceptional cases.

	/* "function" is first non-space token */
	"^[\t ]*function[\t ].*)\n"
	/* "function" is not first token */
	"^.*[^$_[:alnum:]]function[\t ].*\n"

> +	 /* match normal function in object literal */
> +	 "^[\t ]*([$_[:alpha:]][$_[:alnum:]]*[\t ]*:[\t ]*function[\t ].*)\n"
> +	 /* don't match the function in class, which has more than one ident level */
> +	 "!^(\t{2,}|[ ]{5,})\n"

For some, hopefully universally agreed upon in the JavaScript community,
definition of indentation level. Ok...

> +	 /* match function in class */
> +	 "^[\t ]*((static[\t ]+)?((async|get|set)[\t ]+)?[$_[:alpha:]][$_[:alnum:]]*[\t ]*\\(.*)",

Aren't "get" and "set" as universal identifiers of functions or can they
occur on other contexts? Thinking of it, they can occur in comments
everywhere, so they would pick up too many matches if treated like my
"function" proposal above.

> +	 /* word regex */
> +	 /* hexIntegerLiteral and bigHexIntegerLiteral*/
> +	 "0[xX][0-9a-fA-F][_0-9a-fA-F]*n?|"
> +	 /* octalIntegerLiteral and bigOctalIntegerLiteral */
> +	 "0[oO]?[0-7][_0-7]*n?|"
> +	 /* binaryIntegerLiteral and bigBinaryIntegerLiteral */
> +	 "(0[bB][01][_01]*n?)|"
> +	 /* decimalLiteral */
> +	 "(0|[1-9][_0-9]*)?\\.?[0-9][_0-9]*([eE][+-]?[_0-9]+)?|"
> +	 /* bigDecimalLiteral */
> +	 "(0|[1-9][_0-9]*)n|"

You do not have to make the word-regex so tight that it excludes
incorrect literals because you can assume that incorrect literals will
not occur. In particular integers beginning with a 0 need not be treated
specially. You can fold the octal and decimal integers into a single
expression:

	"[0-9][oO]?[_0-9.]*)([eE][+-]?[_0-9]+)?n?"

Are floatingpoint literals beginning with a decimal point like .5 not
permitted?

Please follow the custom to place the alternation character "|" at the
beginning of the next line, not at the end of the previous.

> +	 /* punctuations */
> +	 "\\{|\\}|\\(|\\)|\\.|\\.{3}|;|,|<|>|<=|>=|==|!=|={3}|!==|\\+|-|\\*|/|%|\\*{2}|"
> +	 "\\+{2}|--|<<|>>|>>>|&|\\||\\^|!|~|&&|\\|{2}|\\?{1,2}|:|=|\\+=|-=|\\*=|%=|\\*{2}=|"
> +	 "<<=|>>=|>>>=|&=|\\|=|\\^=|&&=|\\|{2}=|\\?{2}=|=>|"

You could collaps many of the operators into single alternatives, but if
you prefer it this way, it is fine, too. One example:

	">{1,3}="

But please remove the single-character operators from the list, because
there is an implicit single-character alternative that is not visible in
the code here.

> +	 /* identifiers */
> +	 "[$_[:alpha:]][$_[:alnum:]]*"),
>  PATTERNS("markdown",
>  	 "^ {0,3}#{1,6}[ \t].*",
>  	 /* -- */

-- Hannes
